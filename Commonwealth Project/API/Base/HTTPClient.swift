//
//  HTTPClient.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 29/11/20.
//

import Foundation
import RxSwift

protocol ClientAPI {
    var httpClient: HTTPClient { get }
}

protocol HTTPClient {
    func send<T: Codable>(request apiRequest: HTTPRequest) -> Single<T>
}

protocol APIService {
    associatedtype T: Codable
    
    func request(parameters: [String: Any], onSuccess: @escaping (T) -> Void, onError: @escaping (HTTPError) -> Void)
}

extension APIService {
    func parse(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let model: T = try decoder.decode(T.self, from: data)
        return model
    }
}

protocol HTTPIdentifier {
    var baseUrl: URL { get }
    var baseUrlOne: URL { get }
    var baseUrlTwo: URL { get }
}

class BaseIdentifier: HTTPIdentifier {
    
    #if DEBUG
        var baseUrl = URL(string: "http://dummy.restapiexample.com/api/")!
    #else
        var baseUrl = URL(string: "http://dummy.restapiexample.com/api/")!
    #endif
    
    #if DEBUG
        var baseUrlOne = URL(string: "https://newsapi.org/")!
    #else
        var baseUrlOne = URL(string: "https://newsapi.org/")!
    #endif
    
    #if DEBUG
        var baseUrlTwo = URL(string: "https://private-anon-988cd29f17-mymed.apiary-mock.com/")!
    #else
        var baseUrlTwo = URL(string: "https://private-anon-988cd29f17-mymed.apiary-mock.com/")!
    #endif
}
