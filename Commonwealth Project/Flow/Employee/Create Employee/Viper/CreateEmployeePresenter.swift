//
//  CreateEmployeePresenter.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 10/12/20.
//

import Foundation

typealias CreateEmployeePresenterDependencies = (
    interactor: CreateEmployeeInteractor,
    router: CreateEmployeeRouterOutput
)

final class CreateEmployeePresenter: Presenterable {

    private weak var view: CreateEmployeeViewInput!
    let dependencies: CreateEmployeePresenterDependencies

    init(view: CreateEmployeeViewInput, dependencies: CreateEmployeePresenterDependencies) {
        self.view = view
        self.dependencies = dependencies
    }
}

extension CreateEmployeePresenter: CreateEmployeeViewOutput {
    func onShowAPIOne() {
        dependencies.router.ShowApiOne()
    }
    
    func onShowAPITwo() {
        dependencies.router.ShowApiTwo()
    }
    
    func onShowAllEmployeeTapped() {
        dependencies.router.ShowAllEmployee()
    }
    
    
}
    
extension CreateEmployeePresenter: CreateEmployeeInteractorOutput {

}
