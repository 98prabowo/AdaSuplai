//
//  Payment.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 15/11/21.
//

import Foundation

struct Payment: Codable {
    let paymentType: String
    let name: String
    let code: String
    let logo: String
    let isActivated: Bool
    
    enum CodingKeys: String, CodingKey {
        case paymentType, name, code, logo
        case isActivated = "is_activated"
    }
}
