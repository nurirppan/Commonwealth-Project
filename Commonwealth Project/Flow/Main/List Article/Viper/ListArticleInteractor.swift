//
//  ListArticleInteractor.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation

protocol ListArticleInteractorOutput: AnyObject {
    func onSuccessRequest(articles: [HeadlineResponseDetail])
    func onErrorRequest(_ error: HTTPError)
}

final class ListArticleInteractor: Interactorable {
    
    private let api: HeadlineAPIService
    private let sourceId: String
    var originArticles = [HeadlineResponseDetail]()
    weak var presenter: ListArticleInteractorOutput?
    
    init(api: HeadlineAPIService, sourceId: String) {
        self.api = api
        self.sourceId = sourceId
    }
    
    func requestArticles(keyword: String?) {
        let body = HeadlineBody(q: keyword, sources: self.sourceId)
        
        self.api.request(parameters: body.dictionary ?? [String: Any]()) { (response) in
            let result = self.outputTransformModel(response)
            switch result {
            case .success(let model):
                self.originArticles = model
                self.presenter?.onSuccessRequest(articles: model)
            case .failure(let error):
                self.presenter?.onErrorRequest(error)
            }
        } onError: { (error) in
            self.presenter?.onErrorRequest(error)
        }
    }
    
    private func outputTransformModel(_ response: HeadlineResponse) -> Result<[HeadlineResponseDetail], HTTPError> {
        if let status = response.status {
            if status == "ok" {
                return .success(response.articles)
            }
            return .failure(HTTPError.custom(response.message ?? "Internal Server Error!"))
        }
        return .failure(HTTPError.internalError)
    }
}
