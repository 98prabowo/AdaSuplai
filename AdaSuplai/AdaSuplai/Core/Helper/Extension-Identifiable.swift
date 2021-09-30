//
//  Extension-Identifiable.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 30/09/21.
//

import Foundation

extension Identifiable where Self: NSObject {
    public static var identifier: String {
        String(describing: self)
    }
}
