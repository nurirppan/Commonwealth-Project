//
//  ScheduleProvider.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 29/11/20.
//

import Foundation
import RxSwift

class ScheduleProvider {
    
    static let shared: ScheduleProvider = ScheduleProvider()
    
    public let main = MainScheduler.instance
    public let background = ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background)
}
