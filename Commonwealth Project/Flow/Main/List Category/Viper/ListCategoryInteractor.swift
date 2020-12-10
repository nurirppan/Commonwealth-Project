//
//  ListCategoryInteractor.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation

protocol ListCategoryInteractorOutput: AnyObject {
    func onSuccessRequest(categories: [String])
    func onErrorRequest(_ error: HTTPError)
    func onGetSources(_ sources: [SourceResponseDetail])
}

final class ListCategoryInteractor: Interactorable {
    
    private let api: SourceAPIService
    private var originSources = [SourceResponseDetail]()
    weak var presenter: ListCategoryInteractorOutput?
    
    init(api: SourceAPIService) {
        self.api = api
    }
    
    func requestSource() {
        let body = SourceBody() // disini ke 5
        
        self.api.request(parameters: body.dictionary ?? [String: Any]()) { (response) in
            let result = self.outputTransformModel(response)
            switch result {
            case .success(let model):
                self.originSources = model
                let categories = self.extractUniqueCategory(responses: model)
                self.presenter?.onSuccessRequest(categories: categories)
            case .failure(let error):
                self.presenter?.onErrorRequest(error)
            }
        } onError: { (error) in
            self.presenter?.onErrorRequest(error)
        }
    }
    
    private func outputTransformModel(_ response: SourceResponse) -> Result<[SourceResponseDetail], HTTPError> {
        if let status = response.status {
            if status == "ok" {
                return .success(response.sources)
            }
            return .failure(HTTPError.custom(response.message ?? "Internal Server Error!"))
        }
        return .failure(HTTPError.internalError)
    }
    
    private func extractUniqueCategory(responses: [SourceResponseDetail]) -> [String] {
        let categories = responses.map { $0.category }.compactMap { $0 }
        let uniqueness = Array(Set(categories)).sorted()
        return uniqueness
    }
    
    func filterSourcesBy(category: String) {
        let sourcesFiltered = self.originSources.filter { $0.category == category }
        self.presenter?.onGetSources(sourcesFiltered)
    }
}
