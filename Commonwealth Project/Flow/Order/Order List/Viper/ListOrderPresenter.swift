//
//  ListOrderPresenter.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation

typealias ListOrderPresenterDependencies = (
    interactor: ListOrderInteractor,
    router: ListOrderRouterOutput
)

final class ListOrderPresenter: Presenterable {

    private weak var view: ListOrderViewInput!
    let dependencies: ListOrderPresenterDependencies

    init(view: ListOrderViewInput, dependencies: ListOrderPresenterDependencies) {
        self.view = view
        self.dependencies = dependencies
    }
}

extension ListOrderPresenter: ListOrderViewOutput {
    
    func viewDidLoad() {
        view.onViewState(.loading)
        dependencies.interactor.requestListOfMedications()
    }
    
    func onOrderTapped(id: Int) {
        dependencies.interactor.onOrderTapped(id: id)
    }
}
    
extension ListOrderPresenter: ListOrderInteractorOutput {
    
    func onOrderTapped(_ id: Int) {
        dependencies.router.showOrderDetail(id: id)
    }
    
    func onSuccessRequest(model: [ListOfMedication]) {
        view.onViewState(.close)
        view.onFetchOrders(orders: model)
    }
    
    func onErrorRequest(_ error: HTTPError) {
        view.onViewState(.failure(error.readableError))
    }
}
