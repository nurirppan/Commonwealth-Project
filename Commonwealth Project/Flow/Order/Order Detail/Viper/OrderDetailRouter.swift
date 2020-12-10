//
//  OrderDetailRouter.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 03/12/20.
//

import Foundation

struct OrderDetailRouterInput {
    
    private func view(id: Int) -> OrderDetailVC {
        let view = OrderDetailVC()
        let service = MedicationDetailAPIService(httpClient: HTTPService(identifier: BaseIdentifier()), id: id)
        let interactor = OrderDetailInteractor(id: id, api: service)
        let dependencies = OrderDetailPresenterDependencies(interactor: interactor, router: OrderDetailRouterOutput(view))
        let presenter = OrderDetailPresenter(view: view, dependencies: dependencies)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
    
    func push(from: Viewable, id: Int) {
        let view = self.view(id: id)
        from.push(view, animated: true)
    }
    
}

final class OrderDetailRouterOutput: Routerable {

    private(set) weak var view: Viewable!

    init(_ view: Viewable) {
        self.view = view
    }

}
