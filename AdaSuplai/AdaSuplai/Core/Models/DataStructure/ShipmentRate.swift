//
//  ShipmentRate.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 24/11/21.
//

import Foundation

struct ShipmentRate: Codable {
    let metadata: ShipmentRateMetadata
    let data: ShipmentRateData
    let pagination: ShipmentRatePagination
}
