//
//  Extension-Identifiable.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 30/09/21.
//

import Foundation
import UIKit

extension Identifiable where Self: NSObject {
    /// Identifier for a nib class. Default to class name.
    public static var identifier: String {
        String(describing: self)
    }
    
    /// Create UINib for a nib class.
    public static func nib() -> UINib {
        return UINib(nibName: Self.identifier, bundle: nil)
    }
}
