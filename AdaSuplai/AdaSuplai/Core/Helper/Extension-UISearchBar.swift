//
//  Extension-SearchBar.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 13/10/21.
//

import Foundation
import UIKit

extension UISearchBar {
    func setTextFieldColor(_ color: UIColor) {
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = color
        }
    }
}
