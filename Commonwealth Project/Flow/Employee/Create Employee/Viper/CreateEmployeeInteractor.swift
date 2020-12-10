//
//  CreateEmployeeInteractor.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 10/12/20.
//

import Foundation

protocol CreateEmployeeInteractorOutput: AnyObject {
}

final class CreateEmployeeInteractor: Interactorable {
    
    weak var presenter: CreateEmployeeInteractorOutput?
    
    init() { }

    
}
