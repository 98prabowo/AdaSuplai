//
//  Extension-Data.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 02/11/21.
//

import Foundation

extension Data {
    /// Append string in `Data` instance.
    ///
    /// - parameter string: An instance of `String` that will be appended to instance of `Data`.
    mutating func append(_ string: String) {
        let data = Data(string.utf8)
        self.append(data)
    }
}
