//
//  ListOfMedicationAPIService.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 03/12/20.
//

import Foundation

class ListOfMedicationAPIService: APIService {
    
    typealias T = [ListOfMedication]
    
    private class GetListOfMedication: HTTPRequest {
        var method = HTTPMethod.GET
        var path = "/medications"
        var parameters: [String: Any]
        var apiVersion = ApiVersion.v1
        var authentication = HTTPAuth.tokenType.basic
        var header = HeaderType.basic
        
        init(parameters: [String: Any]) {
            self.parameters = parameters
        }
    }
    
    let httpCLient: HTTPService
    
    init(httpClient: HTTPService) {
        self.httpCLient = httpClient
    }
    
    func request(parameters: [String : Any], onSuccess: @escaping ([ListOfMedication]) -> Void, onError: @escaping (HTTPError) -> Void) {
        self.httpCLient.sendTwo(request: GetListOfMedication(parameters: parameters)) { (data) in
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
