//
//  Extension-UIViewController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 02/11/21.
//

import Foundation
import UIKit

extension UIViewController {
    /// Add Hide Keyboard when View Clicked
    func initializeHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
}
