//
//  RequestDestination.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 25/11/21.
//

import Foundation

struct RequestDestination: Codable {
    let areaID: Int
    let suburbID: Int
    let lat, lng: String

    enum CodingKeys: String, CodingKey {
        case areaID = "area_id"
        case suburbID = "suburb_id"
        case lat, lng
    }
    
    init (
        areaID: Int,
        suburbID: Int,
        lat: String,
        lng: String) {
            self.areaID = areaID
            self.suburbID = suburbID
            self.lat = lat
            self.lng = lng
        }
}
