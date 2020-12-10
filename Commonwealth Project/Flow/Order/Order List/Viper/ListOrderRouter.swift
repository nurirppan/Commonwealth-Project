//
//  ListOrderRouter.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation
import UIKit

struct OrderListRouterInput {
    
    private func view() -> ListOrderVC {
        let view = ListOrderVC()
        let service = ListOfMedicationAPIService(httpClient: HTTPService(identifier: BaseIdentifier()))
        let interactor = ListOrderInteractor(api: service)
        let dependencies = ListOrderPresenterDependencies(interactor: interactor, router: ListOrderRouterOutput(view))
        let presenter = ListOrderPresenter(view: view, dependencies: dependencies)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
    
    func setRoot(_ navController: UINavigationController?) {
        let view = self.view()
        navController?.setViewControllers([view], animated: false)
        bottomUpAnimation(navController)
    }
    
    func push(from: Viewable) {
        let view = self.view()
        from.push(view, animated: true)
    }

    func present(from: Viewable) {
        let nav = UINavigationController(rootViewController: self.view())
        from.present(nav, animated: true)
    }
    
    private func bottomUpAnimation(_ navController: UINavigationController?) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        navController?.view.layer.add(transition, forKey: nil)
    }
}

final class ListOrderRouterOutput: Routerable {

    private(set) weak var view: Viewable!

    init(_ view: Viewable) {
        self.view = view
    }
    
    func showOrderDetail(id: Int) {
        OrderDetailRouterInput().push(from: view, id: id)
    }

}
