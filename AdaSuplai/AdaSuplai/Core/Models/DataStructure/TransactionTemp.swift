//
//  TransactionTemp.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 29/11/21.
//

import Foundation

struct TransactionTemp: Codable {
    let userID: String
    let supplierID: String
    let shipperData: ShipmentPrice
    let items: [TransactionProduct]
    let bankCode: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case supplierID = "supplier_id"
        case shipperData = "shipper_data"
        case bankCode = "bank_code"
        case items
    }
}
