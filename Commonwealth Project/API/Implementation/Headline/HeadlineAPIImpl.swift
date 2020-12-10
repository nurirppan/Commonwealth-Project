//
//  HeadlineAPIImpl.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 29/11/20.
//

import Foundation
import RxSwift

class HeadlineAPIImpl: HeadlineAPI {
    
    private class GetHeadlines: HTTPRequest {
        var method = HTTPMethod.GET
        var path = "/top-headlines"
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
    
    func request(parameters: [String: Any]) -> Single<HeadlineResponse> {
        return httpClient.send(request: GetHeadlines(parameters: parameters))
    }
}

class HeadlineAPIService: APIService {
    
    typealias T = HeadlineResponse
    
    private class GetHeadlines: HTTPRequest {
        var method = HTTPMethod.GET
        var path = "/top-headlines"
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
    
    func request(parameters: [String : Any], onSuccess: @escaping (HeadlineResponse) -> Void, onError: @escaping (HTTPError) -> Void) {
        self.httpClient.send(request: GetHeadlines(parameters: parameters)) { (data) in
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
