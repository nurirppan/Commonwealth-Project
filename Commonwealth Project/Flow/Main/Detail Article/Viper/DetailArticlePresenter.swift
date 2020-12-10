//
//  DetailArticlePresenter.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation

typealias DetailArticlePresenterDependencies = (
    interactor: DetailArticleInteractor,
    router: DetailArticleRouterOutput
)

final class DetailArticlePresenter: Presenterable {

    private weak var view: DetailArticleViewInput!
    let dependencies: DetailArticlePresenterDependencies

    init(view: DetailArticleViewInput, dependencies: DetailArticlePresenterDependencies) {
        self.view = view
        self.dependencies = dependencies
    }
    
}

extension DetailArticlePresenter: DetailArticleViewOutput {
    func viewDidLoad() {
        self.view.onWebview(resource: self.dependencies.interactor.resource)
    }
    
    func onDoneTapped() {
        self.dependencies.router.dismiss(animated: true)
    }
}

extension DetailArticlePresenter: DetailArticleInteractorOutput {
    
}
