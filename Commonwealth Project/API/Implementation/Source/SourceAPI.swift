//
//  SourceAPI.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 29/11/20.
//

import Foundation
import RxSwift

protocol SourceAPI: ClientAPI {
    func request(parameters: [String: Any]) -> Single<SourceResponse>
}
