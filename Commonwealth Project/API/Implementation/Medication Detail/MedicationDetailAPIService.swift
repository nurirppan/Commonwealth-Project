//
//  MedicationDetailAPIService.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 03/12/20.
//

import Foundation

class MedicationDetailAPIService: APIService {
    
    typealias T = MedicationDetailResponse
    
    var id = 0
    
    class GetMedicationDetail: HTTPRequest {
        var method = HTTPMethod.GET
        var path = "/medications/"
        var parameters: [String : Any]
        var apiVersion = ApiVersion.v1
        var authentication = HTTPAuth.tokenType.basic
        var header = HeaderType.basic
        
        init(parameters: [String : Any], id: Int) {
            self.parameters = parameters
            self.path = "\(self.path)\(id)"
        }
    }
    
    let httpClient: HTTPService
    
    init(httpClient: HTTPService, id: Int) {
        self.httpClient = httpClient
        self.id = id
    }
    
    func request(parameters: [String : Any], onSuccess: @escaping (MedicationDetailResponse) -> Void, onError: @escaping (HTTPError) -> Void) {
        self.httpClient.send(request: GetMedicationDetail(parameters: parameters, id: self.id)) { (data) in
            do {
                let model = try self.parse(data)
                onSuccess(model)
            } catch {
                onError(.uncodableIssue)
            }
        } onFailure: { (error) in
            onError(error)
        }
        
    }
    
    
}
//https://private-anon-988cd29f17-mymed.apiary-mock.com/v1/medications/570 -> expextasi
//https://private-anon-988cd29f17-mymed.apiary-mock.com/v1/medications?id=570 -> realita
//https://private-anon-988cd29f17-mymed.apiary-mock.com/v1/medications
