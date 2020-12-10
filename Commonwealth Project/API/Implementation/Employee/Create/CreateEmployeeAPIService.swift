//
//  CreateEmployeeAPIService.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 10/12/20.
//

import Foundation

class CreateEmployeeAPIService: APIService {
    
    typealias T = [CreateEmployeeResponse]
    
    private class PostCreateEmployee: HTTPRequest {
        var method = HTTPMethod.POST
        var path = "/create"
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
    
    func request(parameters: [String : Any], onSuccess: @escaping ([CreateEmployeeResponse]) -> Void, onError: @escaping (HTTPError) -> Void) {
        self.httpCLient.send(request: PostCreateEmployee(parameters: parameters)) { (data) in
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
