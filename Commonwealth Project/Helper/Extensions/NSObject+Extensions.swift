//
//  NSObject+Extensions.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 29/11/20.
//

import Foundation

extension NSObject {
    
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
