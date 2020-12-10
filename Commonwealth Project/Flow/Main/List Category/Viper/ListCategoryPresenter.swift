//
//  ListCategoryPresenter.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation

typealias ListCategoryPresenterDependencies = (
    interactor: ListCategoryInteractor,
    router: ListCategoryRouterOutput
)

final class ListCategoryPresenter: Presenterable {

    private weak var view: ListCategoryViewInput!
    let dependencies: ListCategoryPresenterDependencies

    init(view: ListCategoryViewInput, dependencies: ListCategoryPresenterDependencies) {
        self.view = view
        self.dependencies = dependencies
    }
    
}

extension ListCategoryPresenter: ListCategoryViewOutput {
    func viewDidLoad() {
        view.onViewState(.loading) // disini ke 2
        dependencies.interactor.requestSource() // disini ke 4
    }
    
    func onCategoryTapped(category: String) {
        dependencies.interactor.filterSourcesBy(category: category)
    }
    
}

extension ListCategoryPresenter: ListCategoryInteractorOutput {
    func onSuccessRequest(categories: [String]) {
        view.onViewState(.close)
        view.onFetchCategories(categories: categories)
    }
    
    func onErrorRequest(_ error: HTTPError) {
        view.onViewState(.failure(error.readableError))
    }
    
    func onGetSources(_ sources: [SourceResponseDetail]) {
        dependencies.router.showList(sources: sources)
    }
    
}
