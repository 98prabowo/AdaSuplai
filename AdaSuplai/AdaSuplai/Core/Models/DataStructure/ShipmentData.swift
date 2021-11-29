//
//  ShipmentData.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 24/11/21.
//

import Foundation

class ShipmentData: Codable {
    let height, itemValue, length: Int
    let weight: Double
    let width: Int
    let cod: Bool
    let destination: RequestDestination
    let forOrder: Bool
    let limit: Int
    let origin: RequestDestination
    let page: Int
    let sortBy: [String]

    enum CodingKeys: String, CodingKey {
        case height
        case itemValue = "item_value"
        case length, weight, width, cod, destination
        case forOrder = "for_order"
        case limit, origin, page
        case sortBy = "sort_by"
    }
    
    init(height: Int,
         itemValue: Int,
         length: Int,
         weight: Double,
         width: Int,
         cod: Bool,
         destination: RequestDestination,
         forOrder: Bool,
         limit: Int,
         origin: RequestDestination,
         page: Int,
         sortBy: [String]) {
        self.height = height
        self.itemValue = itemValue
        self.length = length
        self.weight = weight
        self.width = width
        self.cod = cod
        self.destination = destination
        self.forOrder = forOrder
        self.limit = limit
        self.origin = origin
        self.page = page
        self.sortBy = sortBy
    }
    
    init(products: [ProductCart], destination: RequestDestination, origin: RequestDestination) {
        self.height = 30
        self.itemValue = 30
        self.length = 30
        self.weight = 0.5
        self.width = 30
        self.cod = false
        self.forOrder = false
        self.limit = 60
        self.page = 1
        self.sortBy = ["final-price"]
        self.destination = destination
        self.origin = origin
    }
}
