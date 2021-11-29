//
//  Rate.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 24/11/21.
//

import Foundation

struct Rate: Codable {
    let id: Int
    let name: String
    let type: TypeEnum
    let rateDescription, fullDescription: String
    let isHubless: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, type
        case rateDescription = "description"
        case fullDescription = "full_description"
        case isHubless = "is_hubless"
    }
}
