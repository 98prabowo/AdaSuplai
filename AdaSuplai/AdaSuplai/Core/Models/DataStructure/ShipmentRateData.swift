//
//  ShipmentRateData.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 24/11/21.
//

import Foundation

struct ShipmentRateData: Codable {
    let origin, destination: ResponseDestination
    let pricings: [ShipmentPrice]
}
