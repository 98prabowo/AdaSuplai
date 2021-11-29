//
//  TransactionResponse.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 29/11/21.
//

import Foundation

struct TransactionResponse: Codable {
    let orderStatus: String
    let isClosed: Bool
    let status, currency, name, id: String
    let ownerID: String
    let externalID: String
    let bankCode: String
    let merchantCode: String
    let accountNumber: String
    let expectedAmount: Int
    let expirationDate: String
    let isSingleUse: Bool
    
    enum CodingKeys: String, CodingKey {
        case orderStatus = "create_order_status"
        case isClosed = "is_closed"
        case status, currency, name, id
        case ownerID = "owner_id"
        case externalID = "external_id"
        case bankCode = "bank_code"
        case merchantCode = "merchant_code"
        case accountNumber = "account_number"
        case expectedAmount = "expected_amount"
        case expirationDate = "expiration_date"
        case isSingleUse = "is_single_use"
    }
}
