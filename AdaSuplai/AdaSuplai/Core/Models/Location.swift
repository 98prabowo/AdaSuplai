//
//  Location.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 26/10/21.
//

import Foundation

struct Location: Codable {
    let province: String
    let city: [String]
    
    enum CodingKeys: String, CodingKey {
        case province = "provinsi"
        case city = "kota"
    }
}
    
public enum Provinces {
    static let jakarta = "DKI Jakarta"
    static let jawaBarat = "Jawa Barat"
    static let jawaTengah = "Jawa Tengah"
    static let jogjakarta = "DI Yogyakarta"
    static let jawaTimur = "Jawa Timur"
    static let bali = "Bali"
}
