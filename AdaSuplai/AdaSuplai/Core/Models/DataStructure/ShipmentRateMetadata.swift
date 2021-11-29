//
//  ShipmentRateMetadata.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 24/11/21.
//

import Foundation

struct ShipmentRateMetadata: Codable {
    let path: String
    let httpStatusCode: Int
    let httpStatus: String
    let timestamp: Int

    enum CodingKeys: String, CodingKey {
        case path
        case httpStatusCode = "http_status_code"
        case httpStatus = "http_status"
        case timestamp
    }
}
