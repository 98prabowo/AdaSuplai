//
//  Logistic.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 24/11/21.
//

import Foundation

struct Logistic: Codable {
    let id: Int
    let name: String
    let logoURL: String
    let code, companyName: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case logoURL = "logo_url"
        case code
        case companyName = "company_name"
    }
}
