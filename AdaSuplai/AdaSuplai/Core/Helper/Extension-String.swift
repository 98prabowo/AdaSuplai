//
//  Extension-String.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 07/10/21.
//

import Foundation

extension String {
    var strikethroughText: NSMutableAttributedString {
        let attributedString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
}
