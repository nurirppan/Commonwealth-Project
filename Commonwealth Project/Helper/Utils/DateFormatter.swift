//
//  DateFormatter.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 03/12/20.
//

import Foundation
import UIKit

enum FromTypeDate: String {
    case defaultFormat = "yyyy-MM-dd HH:mm:s"
    case resultFormat = "dd MMM yyyy HH:mm"
}

struct DateFormatters {
    
    static func convert(valueDate: String, from: FromTypeDate, to: FromTypeDate) -> String {
        if valueDate.isEmpty {
            return "Date Format is Wrong"
        } else {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = from.rawValue
            let showDate = inputFormatter.date(from: valueDate)
            inputFormatter.dateFormat = to.rawValue
            let resultString = inputFormatter.string(from: showDate!)
            return resultString
        }
    }
}

//Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
//09/12/2018                        --> MM/dd/yyyy
//09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
//Sep 12, 2:11 PM                   --> MMM d, h:mm a
//September 2018                    --> MMMM yyyy
//Sep 12, 2018                      --> MMM d, yyyy
//Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
//2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
//12.09.18                          --> dd.MM.yy
//10:41:02.112                      --> HH:mm:ss.SSS
