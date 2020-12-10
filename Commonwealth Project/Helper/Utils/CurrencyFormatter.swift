//
//  CurrencyFormatter.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 03/12/20.
//

import Foundation

struct CurrencyFormatter {
    
    static func convert(value: Int) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = ""
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale(identifier: "id_ID")
        currencyFormatter.groupingSeparator = "."
        let priceString = currencyFormatter.string(from: NSNumber(value: value))!
        
        return value == 0 ? "Rp -" : "Rp \(priceString)"
    }
}
