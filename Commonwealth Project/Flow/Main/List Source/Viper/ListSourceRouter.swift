//
//  ListSourceRouter.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
// 

import Foundation
import UIKit

struct ListSourceRouterInput {

    private func view(sources: [SourceResponseDetail]) -> ListSourceVC {
        let view = ListSourceVC()
        let interactor = ListSourceInteractor(originSources: sources)
        let dependencies = ListSourcePresenterDependencies(interactor: interactor, router: ListSourceRouterOutput(view))
        let presenter = ListSourcePresenter(view: view, dependencies: dependencies)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }

    func push(from: Viewable, sources: [SourceResponseDetail]) {
        let view = self.view(sources: sources)
        from.push(view, animated: true)
    }

    func present(from: Viewable, sources: [SourceResponseDetail]) {
        let nav = UINavigationController(rootViewController: self.view(sources: sources))
        from.present(nav, animated: true)
    }
}

final class ListSourceRouterOutput: Routerable {

    private(set) weak var view: Viewable!

    init(_ view: Viewable) {
        self.view = view
    }

    func showArticles(sourceId: String) {
        ListArticleRouterInput().push(from: view, sourceId: sourceId)
    }
}
