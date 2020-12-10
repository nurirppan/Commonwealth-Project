//
//  ListOrderInteractor.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation

protocol ListOrderInteractorOutput: AnyObject {
    func onErrorRequest(_ error: HTTPError)
    func onSuccessRequest(model: [ListOfMedication])
    func onOrderTapped(_ id: Int)
}

final class ListOrderInteractor: Interactorable {
    
    private let api: ListOfMedicationAPIService
    weak var presenter: ListOrderInteractorOutput?
    
    init(api: ListOfMedicationAPIService) {
        self.api = api
    }
    
    func requestListOfMedications() {
        self.api.request(parameters: [String: Any]()) { (response) in
            let result = self.outputTransformModel(response)
            switch result {
            case .success(let model):
                self.presenter?.onSuccessRequest(model: model)
            case .failure(let error):
                self.presenter?.onErrorRequest(error)
            }
        } onError: { (error) in
            self.presenter?.onErrorRequest(error)
            
        }
    }
    
    private func outputTransformModel(_ response: [ListOfMedication]) -> Result<[ListOfMedication], HTTPError> {
        if !response.isEmpty {
            return .success(response)
        }
        return .failure(HTTPError.internalError)
    }
    
    func onOrderTapped(id: Int) {
        self.presenter?.onOrderTapped(id)
    }
    
}


