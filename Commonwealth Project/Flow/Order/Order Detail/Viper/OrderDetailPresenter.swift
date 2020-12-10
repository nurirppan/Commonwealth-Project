//
//  OrderDetailPresenter.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 03/12/20.
//

import Foundation

typealias OrderDetailPresenterDependencies = (
    interactor: OrderDetailInteractor,
    router: OrderDetailRouterOutput
)

final class OrderDetailPresenter: Presenterable {
    
    private weak var view: OrderDetailViewInput!
    let dependencies: OrderDetailPresenterDependencies
    
    init(view: OrderDetailViewInput, dependencies: OrderDetailPresenterDependencies) {
        self.view = view
        self.dependencies = dependencies
    }
}

extension OrderDetailPresenter: OrderDetailViewOutput {
    func viewDidLoad() {
        view.onViewState(.loading)
        dependencies.interactor.requestMedicationDetail()
    }
    
    
}

extension OrderDetailPresenter: OrderDetailInteractorOutput {
    func onSuccessRequest(model: MedicationDetailResponse) {
        view.onViewState(.close)
        view.onFetchCategories(model: model)
    }
    
    func onErrorRequest(_ error: HTTPError) {
        view.onViewState(.failure(error.readableError))
    }
    
    
}
