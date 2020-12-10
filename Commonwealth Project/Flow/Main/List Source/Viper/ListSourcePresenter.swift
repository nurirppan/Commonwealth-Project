//
//  ListSourcePresenter.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
// 

import Foundation

typealias ListSourcePresenterDependencies = (
    interactor: ListSourceInteractor,
    router: ListSourceRouterOutput
)

final class ListSourcePresenter: Presenterable {

    private weak var view: ListSourceViewInput!
    let dependencies: ListSourcePresenterDependencies

    init(view: ListSourceViewInput, dependencies: ListSourcePresenterDependencies) {
        self.view = view
        self.dependencies = dependencies
    }
    
}

extension ListSourcePresenter: ListSourceViewOutput {
    func viewDidLoad() {
        self.view.onFetchSources(sources: dependencies.interactor.originSources)
    }
    
    func onSourceTapped(sourceId: String) {
        self.dependencies.router.showArticles(sourceId: sourceId)
    }
    
    func onSearchSources(keyword: String) {
        if keyword.count > 2 {
            self.dependencies.interactor.searchSources(keyword: keyword)
        } else {
            self.view.onFetchSources(sources: dependencies.interactor.originSources)
        }
    }
    
}

extension ListSourcePresenter: ListSourceInteractorOutput {
    func onSearchSources(_ sources: [SourceResponseDetail]) {
        self.view.onFetchSources(sources: sources)
    }
    
}
