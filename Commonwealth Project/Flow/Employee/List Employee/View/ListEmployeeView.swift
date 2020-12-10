//
//  ListEmployeeView.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 10/12/20.
//

import Foundation

protocol ListEmployeeViewInput: AnyObject {
    func onViewState(_ state: BasicUIState)
}

protocol ListEmployeeViewOutput: AnyObject {
}
