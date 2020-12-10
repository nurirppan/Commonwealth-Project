//
//  ListArticlePresenter.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation

typealias ListArticlePresenterDependencies = (
    interactor: ListArticleInteractor,
    router: ListArticleRouterOutput
)

final class ListArticlePresenter: Presenterable {

    private weak var view: ListArticleViewInput!
    let dependencies: ListArticlePresenterDependencies

    init(view: ListArticleViewInput, dependencies: ListArticlePresenterDependencies) {
        self.view = view
        self.dependencies = dependencies
    }
    
}

extension ListArticlePresenter: ListArticleViewOutput {
    func viewDidLoad() {
        self.dependencies.interactor.requestArticles(keyword: nil)
    }
    
    func onArticleTapped(resource: WebviewResourceType) {
        self.dependencies.router.showDetail(resource: resource)
    }
    
    func onSearchArticles(keyword: String) {
        self.dependencies.interactor.requestArticles(keyword: keyword)
    }
    
}

extension ListArticlePresenter: ListArticleInteractorOutput {
    func onSuccessRequest(articles: [HeadlineResponseDetail]) {
        self.view.onViewState(.close)
        self.view.onFetchArticles(articles: articles)
    }
    
    func onErrorRequest(_ error: HTTPError) {
        self.view.onViewState(.failure(error.readableError))
    }
    
}
