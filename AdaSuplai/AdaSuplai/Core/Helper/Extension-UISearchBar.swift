//
//  Extension-SearchBar.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 13/10/21.
//

import Foundation
import UIKit

extension UISearchBar {
    /// Search `UITextField` in `UISearchBar`. Then change it's color.
    ///
    /// - Parameters:
    ///   - color: A `UIColor` that will use as `UITextField` in `UISearchBar` color.
    func setTextFieldColor(_ color: UIColor) {
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = color
        }
    }
}
