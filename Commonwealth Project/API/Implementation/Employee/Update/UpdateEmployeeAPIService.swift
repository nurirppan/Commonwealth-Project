//
//  UpdateEmployeeAPIService.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 10/12/20.
// 

import Foundation

class UpdateEmployeeAPIService: APIService {
    
    typealias T = CreateEmployeeResponse
    
    var id = 0
    
    class PostUpdateEmployee: HTTPRequest {
        var method = HTTPMethod.POST
        var path = "/update/"
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
    
    func request(parameters: [String : Any], onSuccess: @escaping (CreateEmployeeResponse) -> Void, onError: @escaping (HTTPError) -> Void) {
        self.httpClient.send(request: PostUpdateEmployee(parameters: parameters, id: self.id)) { (data) in
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
