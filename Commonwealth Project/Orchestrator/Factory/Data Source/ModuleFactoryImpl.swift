//
//  ModuleFactoryImpl.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 29/11/20.
//

import Foundation

class ModuleFactoryImpl: DataModuleFactory {
    
    func makeBaseIdentifier() -> HTTPIdentifier {
        return BaseIdentifier()
    }
    
    func makeHTTPClient() -> HTTPClient {
        return HTTPClientImpl(identifier: makeBaseIdentifier())
    }
    
    func makeSourceAPI() -> SourceAPI {
        return SourceAPIImpl(httpClient: makeHTTPClient())
    }
    
    func makeHeadlineAPI() -> HeadlineAPI {
        HeadlineAPIImpl(httpClient: makeHTTPClient())
    }
    
}
