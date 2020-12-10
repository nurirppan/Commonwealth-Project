//
//  DataModuleFactory.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 29/11/20.
//

import Foundation

protocol DataModuleFactory {
    // MARK: - HTTP Client
    func makeBaseIdentifier() -> HTTPIdentifier
    func makeHTTPClient() -> HTTPClient
    
    // MARK: - API
    func makeSourceAPI() -> SourceAPI
    func makeHeadlineAPI() -> HeadlineAPI
}
