//
//  ListEmployeePresenter.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 10/12/20.
//

import Foundation

typealias ListEmployeePresenterDependencies = (
    interactor: ListEmployeeInteractor,
    router: ListEmployeeRouterOutput
)

final class ListEmployeePresenter: Presenterable {

    private weak var view: ListEmployeeViewInput!
    let dependencies: ListEmployeePresenterDependencies

    init(view: ListEmployeeViewInput, dependencies: ListEmployeePresenterDependencies) {
        self.view = view
        self.dependencies = dependencies
    }
}

extension ListEmployeePresenter: ListEmployeeViewOutput {
    
}
    
extension ListEmployeePresenter: ListEmployeeInteractorOutput {

}
