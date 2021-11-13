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
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "Rp. "
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = "."
        if let formattedNumber = formatter.string(from: NSNumber(value: self)) {
            result = formattedNumber
        }
        return result
    }
}

extension Int64 {
    /// Return string with `.` format that follor IDR currency format
    var toIDR: String {
        var result = String(self)
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "Rp. "
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = "."
        if let formattedNumber = formatter.string(from: NSNumber(value: self)) {
            result = formattedNumber
        }
        return result
    }
}

extension Float {
    /// Return string with `.` format that follor IDR currency format
    var toIDR: String {
        var result = String(self)
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "Rp. "
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = "."
        if let formattedNumber = formatter.string(from: NSNumber(value: self)) {
            result = formattedNumber
        }
        return result
    }
}

extension Double {
    /// Return string with `.` format that follor IDR currency format
    var toIDR: String {
        var result = String(self)
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "Rp. "
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = "."
        if let formattedNumber = formatter.string(from: NSNumber(value: self)) {
            result = formattedNumber
        }
        return result
    }
}

extension String {
    /// Reverse number formatter back to `Int`
    var toIntRemoveIDR: Int {
        var result: Int = 0
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "Rp. "
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = "."
        if let number = formatter.number(from: self) as? Int {
            result = number
        }
        return result
    }
    
    /// Reverse number formatter back to `Int64`
    var toInt64RemoveIDR: Int64 {
        var result: Int64 = 0
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "Rp. "
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = "."
        if let number = formatter.number(from: self) as? Int64 {
            result = number
        }
        return result
    }
    
    /// Reverse number formatter back to `Float`
    var toFloatRemoveIDR: Float {
        var result: Float = 0
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "Rp. "
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = "."
        if let number = formatter.number(from: self) as? Float {
            result = number
        }
        return result
    }
    
    /// Reverse number formatter back to `Double`
    var toDoubleRemoveIDR: Double {
        var result: Double = 0
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "Rp. "
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = "."
        if let number = formatter.number(from: self) as? Double {
            result = number
        }
        return result
    }
}
