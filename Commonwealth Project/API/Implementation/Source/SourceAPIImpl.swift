//
//  SourceAPIImpl.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 29/11/20.
//

import Foundation
import RxSwift

class SourceAPIImpl: SourceAPI {
    
    private class GetSources: HTTPRequest {
        var method = HTTPMethod.GET
        var path = "/sources"
        var apiVersion = ApiVersion.v2
        var parameters: [String: Any]
        var authentication = HTTPAuth.tokenType.basic
        var header = HeaderType.basic
        
        init(parameters: [String: Any]) {
            self.parameters = parameters
        }
    }
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func request(parameters: [String: Any]) -> Single<SourceResponse> {
        return httpClient.send(request: GetSources(parameters: parameters))
    }
}

class SourceAPIService: APIService {
    
    typealias T = SourceResponse
    
    private class GetSources: HTTPRequest {
        var method = HTTPMethod.GET
        var path = "/sources"
        var apiVersion = ApiVersion.v2
        var parameters: [String: Any]
        var authentication = HTTPAuth.tokenType.basic
        var header = HeaderType.basic
        
        init(parameters: [String: Any]) {
            self.parameters = parameters
        }
    }
    
    let httpClient: HTTPService
    
    init(httpClient: HTTPService) {
        self.httpClient = httpClient
    }
    
    func request(parameters: [String : Any], onSuccess: @escaping (SourceResponse) -> Void, onError: @escaping (HTTPError) -> Void) { // disini ke 6
        self.httpClient.send(request: GetSources(parameters: parameters)) { (data) in
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
