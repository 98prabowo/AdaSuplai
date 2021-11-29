//
//  Transaction.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 25/11/21.
//

import Foundation

struct Transaction: Codable {
    var suppliers: [Supplier]?
    var payment: Payment?
    
    enum CodingKeys: String, CodingKey {
        case suppliers, payment
    }
}
