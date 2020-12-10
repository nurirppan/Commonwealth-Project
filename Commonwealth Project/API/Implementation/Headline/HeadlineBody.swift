//
//  HeadlineBody.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 29/11/20.
//

import Foundation

struct HeadlineBody: Codable {
    let q: String?
    let sources: String
    var apiKey: String = HTTPAuth.shared.apiKey
}
