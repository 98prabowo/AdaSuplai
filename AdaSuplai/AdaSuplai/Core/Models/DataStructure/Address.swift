//
//  Address.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 25/11/21.
//

import Foundation

struct Address: Codable {
    let address: String
    let areaID: Int
    let lat, lng: String

    enum CodingKeys: String, CodingKey {
        case areaID = "area_id"
        case lat, lng, address
    }
    
    init (
        address: String,
        areaID: Int,
        lat: String,
        lng: String) {
            self.address = address
            self.areaID = areaID
            self.lat = lat
            self.lng = lng
        }
}
