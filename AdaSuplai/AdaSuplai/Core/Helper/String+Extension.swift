//
//  Extension-String.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 07/10/21.
//

import Foundation

extension String {
    /// Return a string with strike through text.
    var strikethroughText: NSMutableAttributedString {
        let attributedString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    
    /// Return a string with country code.
    var addCountryCode: String {
        var phoneNumber = String(self)
        var result = ""
        if phoneNumber.contains("0") {
            phoneNumber.removeFirst()
            result.append(contentsOf: "62")
            result.append(phoneNumber)
        } else {
            result.append(phoneNumber)
        }
        return result
    }
    
    /// Return a string without country code.
    var removeCountryCode: String {
        var phoneNumber = String(self)
        var result = ""
        if phoneNumber.contains("0") {
            result.append(phoneNumber)
        } else {
            phoneNumber.removeFirst(2)
            result.append(contentsOf: "0")
            result.append(phoneNumber)
        }
        return result
    }
}

extension String {
    static let userID = "userId"
}
