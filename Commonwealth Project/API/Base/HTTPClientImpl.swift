//
//  HTTPClientImpl.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 29/11/20.
//

import Foundation
import RxSwift

class HTTPClientImpl: HTTPClient {
    private let identifier: HTTPIdentifier
    
    init(identifier: HTTPIdentifier) {
        self.identifier = identifier
    }
    
    func send<T: Codable>(request apiRequest: HTTPRequest) -> Single<T> {
        return Single<T>.create { single in
            let request = apiRequest.request(with: self.identifier.baseUrl)
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, _, _) in
                if HTTPReachability.isConnectedToNetwork() {
                    do {
                        self.log(data: data, from: request)
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let model: T = try decoder.decode(T.self, from: data ?? Data())
                        single(.success(model))
                    } catch let error {
                        print("\n=====HTTPResponseError=====")
                        print("RESPONSE FROM \(request.url?.absoluteString ?? self.identifier.baseUrl.absoluteString) => \((error as NSError).userInfo.debugDescription)")
                        print("====================\n")
                        single(.error(HTTPError.uncodableIssue))
                    }
                } else {
                    single(.error(HTTPError.connectionLost))
                }
            })
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    private func log(data: Data?, from urlRequest: URLRequest) {
        if let data = data {
            print("\n=====HTTPResponse=====")
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("RESPONSE FROM \(urlRequest.url?.absoluteString ?? "") \n\(json)")
                }
            } catch let error {
                print("RESPONSE FROM \(urlRequest.url?.absoluteString ?? "") => \(error.localizedDescription)")
            }
            print("====================\n")
        }
    }
}

class HTTPService {
    private let identifier: HTTPIdentifier
    
    init(identifier: HTTPIdentifier) {
        self.identifier = identifier
    }
    
    func send(request apiRequest: HTTPRequest, onSuccess: @escaping (Data) -> Void, onFailure: @escaping (HTTPError) -> Void) {
        let request = apiRequest.request(with: self.identifier.baseUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [self] (data, _, _) in
            if HTTPReachability.isConnectedToNetwork() {
                self.log(data: data, from: request)
                if let data = data {
                    onSuccess(data)
                } else {
                    onFailure(.internalError)
                }
            } else {
                onFailure(.connectionLost)
            }
        })
        task.resume()
    }
    
    private func log(data: Data?, from urlRequest: URLRequest) {
        if let data = data {
            print("\n=====HTTPResponse=====")
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("RESPONSE FROM \(urlRequest.url?.absoluteString ?? "") \n\(json)")
                }
            } catch let error {
                print("RESPONSE FROM \(urlRequest.url?.absoluteString ?? "") => \(error.localizedDescription)")
            }
            print("====================\n")
        }
    }
    
}
