//
//  OrderDetailInteractor.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 03/12/20.
//

import Foundation

protocol OrderDetailInteractorOutput: AnyObject {
    func onErrorRequest(_ error: HTTPError)
    func onSuccessRequest(model: MedicationDetailResponse)
}

final class OrderDetailInteractor: Interactorable {
    
    private let api: MedicationDetailAPIService
    weak var presenter: OrderDetailInteractorOutput?
    
    private var id: Int = 0
    
    init(id: Int, api: MedicationDetailAPIService) {
        self.id = id
        self.api = api
    }
    
    func requestMedicationDetail() {
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
    
    private func outputTransformModel(_ response: MedicationDetailResponse) -> Result<MedicationDetailResponse, HTTPError> {
        if response.id.isEmpty {
            return .failure(HTTPError.custom("Internal Server Error!"))
        } else if !response.id.isEmpty {
            return .success(response)
        }
        
        return .failure(HTTPError.internalError)
    }
    
    
}
