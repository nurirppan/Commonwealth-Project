//
//  ListEmployeeInteractor.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 10/12/20.
//

import Foundation

protocol ListEmployeeInteractorOutput: AnyObject {
}

final class ListEmployeeInteractor: Interactorable {
    
    weak var presenter: ListEmployeeInteractorOutput?
    
    init() { }

    
}
