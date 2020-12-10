//
//  HeadlineAPI.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 29/11/20.
//

import Foundation
import RxSwift

protocol HeadlineAPI: ClientAPI {
    func request(parameters: [String: Any]) -> Single<HeadlineResponse>
}
