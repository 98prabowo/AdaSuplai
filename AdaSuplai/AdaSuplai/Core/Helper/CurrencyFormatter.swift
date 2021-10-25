//
//  Currency.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 13/10/21.
//

import Foundation

extension Int {
    /// Return string with `.` format that follor IDR currency format
    var toIDR: String {
        var result = String(self)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.groupingSeparator = "."
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) {
            result = formattedNumber
        }
        return result
    }
}

extension Float {
    /// Return string with `.` format that follor IDR currency format
    var toIDR: String {
        var result = String(self)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.groupingSeparator = "."
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) {
            result = formattedNumber
        }
        return result
    }
}

extension Double {
    /// Return string with `.` format that follor IDR currency format
    var toIDR: String {
        var result = String(self)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.groupingSeparator = "."
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) {
            result = formattedNumber
        }
        return result
    }
}
