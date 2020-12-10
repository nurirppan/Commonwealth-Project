//
//  ListArticleRouter.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation
import UIKit

struct ListArticleRouterInput {

    private func view(sourceId: String) -> ListArticleVC {
        let view = ListArticleVC()
        let service = HeadlineAPIService(httpClient: HTTPService(identifier: BaseIdentifier()))
        let interactor = ListArticleInteractor(api: service, sourceId: sourceId)
        let dependencies = ListArticlePresenterDependencies(interactor: interactor, router: ListArticleRouterOutput(view))
        let presenter = ListArticlePresenter(view: view, dependencies: dependencies)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }

    func push(from: Viewable, sourceId: String) {
        let view = self.view(sourceId: sourceId)
        from.push(view, animated: true)
    }

    func present(from: Viewable, sourceId: String) {
        let nav = UINavigationController(rootViewController: self.view(sourceId: sourceId))
        from.present(nav, animated: true)
    }
}

final class ListArticleRouterOutput: Routerable {

    private(set) weak var view: Viewable!

    init(_ view: Viewable) {
        self.view = view
    }

    func showDetail(resource: WebviewResourceType) {
        DetailArticleRouterInput().present(from: view, resources: resource)
    }
}
