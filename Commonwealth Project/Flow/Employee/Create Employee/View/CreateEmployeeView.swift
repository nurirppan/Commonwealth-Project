//
//  CreateEmployeeView.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 10/12/20.
//

import Foundation

protocol CreateEmployeeViewInput: AnyObject {
    func onViewState(_ state: BasicUIState)
}

protocol CreateEmployeeViewOutput: AnyObject {
    func onShowAllEmployeeTapped()
    func onShowAPIOne()
    func onShowAPITwo()
}
