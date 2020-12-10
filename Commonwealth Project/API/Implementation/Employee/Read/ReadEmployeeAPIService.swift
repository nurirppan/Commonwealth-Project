//
//  ReadEmployeeAPIService.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 10/12/20.
//

import Foundation

class ReadEmployeeAPIService: APIService {
    
    typealias T = [ReadEmployeeResponse]
    
    private class GetReadEmployee: HTTPRequest {
        var method = HTTPMethod.GET
        var path = "/employees"
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
    
    func request(parameters: [String : Any], onSuccess: @escaping ([ReadEmployeeResponse]) -> Void, onError: @escaping (HTTPError) -> Void) {
        self.httpCLient.send(request: GetReadEmployee(parameters: parameters)) { (data) in
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
