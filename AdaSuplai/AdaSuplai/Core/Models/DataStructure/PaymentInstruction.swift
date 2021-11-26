//
//  PaymentInstruction.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 18/11/21.
//

import Foundation

struct PaymentInstructions: Codable {
    let id, bankCode: String
    let instructions: [String]
    let paymentMethod: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case bankCode, instructions, paymentMethod
        case v = "__v"
    }
}
