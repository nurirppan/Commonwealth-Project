//
//  DetailArticleRouter.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation
import UIKit

struct DetailArticleRouterInput {

    private func view(resources: WebviewResourceType) -> ArticleVC {
        let view = ArticleVC()
        let interactor = DetailArticleInteractor(resource: resources)
        let dependencies = DetailArticlePresenterDependencies(interactor: interactor, router: DetailArticleRouterOutput(view))
        let presenter = DetailArticlePresenter(view: view, dependencies: dependencies)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }

    func push(from: Viewable, resources: WebviewResourceType) {
        let view = self.view(resources: resources)
        from.push(view, animated: true)
    }

    func present(from: Viewable, resources: WebviewResourceType) {
        let nav = UINavigationController(rootViewController: self.view(resources: resources))
        from.present(nav, animated: true)
    }
}

final class DetailArticleRouterOutput: Routerable {

    private(set) weak var view: Viewable!

    init(_ view: Viewable) {
        self.view = view
    }
}
