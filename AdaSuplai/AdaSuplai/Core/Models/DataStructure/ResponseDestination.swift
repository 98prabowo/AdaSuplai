//
//  ResponseDestination.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 24/11/21.
//

import Foundation

struct ResponseDestination: Codable {
    let areaID: Int
    let areaName: String?
    let suburbID: Int
    let suburbName: String?
    let cityID: Int?
    let cityName: String?
    let provinceID: Int?
    let provinceName: String?
    let countryID: Int?
    let countryName: String?
    let lat, lng: Double

    enum CodingKeys: String, CodingKey {
        case areaID = "area_id"
        case areaName = "area_name"
        case suburbID = "suburb_id"
        case suburbName = "suburb_name"
        case cityID = "city_id"
        case cityName = "city_name"
        case provinceID = "province_id"
        case provinceName = "province_name"
        case countryID = "country_id"
        case countryName = "country_name"
        case lat, lng
    }
    
    init (
        areaID: Int,
        areaName: String,
        suburbID: Int,
        suburbName: String,
        cityID: Int,
        cityName: String,
        provinceID: Int,
        provinceName: String,
        countryID: Int,
        countryName: String,
        lat: Double,
        lng: Double) {
            self.areaID = areaID
            self.areaName = areaName
            self.suburbID = suburbID
            self.suburbName = suburbName
            self.cityID = cityID
            self.cityName = cityName
            self.provinceID = provinceID
            self.provinceName = provinceName
            self.countryID = countryID
            self.countryName = countryName
            self.lat = lat
            self.lng = lng
        }
}
