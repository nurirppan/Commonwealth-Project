//
//  HeadlineResponse.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 29/11/20.
//

import Foundation

struct HeadlineResponse: Codable {
    let status: String?
    let articles: [HeadlineResponseDetail]
    let code: String?
    let message: String?
}

struct HeadlineResponseDetail: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let content: String?
    
    var urlResource: WebviewResourceType? {
        if let url = url {
            return .web(url: url)
        }
        return nil
    }
}
