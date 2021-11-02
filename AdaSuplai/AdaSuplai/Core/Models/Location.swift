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
    
public enum Province: String {
    case jakarta = "DKI Jakarta"
    case jawaBarat = "Jawa Barat"
    case jawaTengah = "Jawa Tengah"
    case jogjakarta = "DI Yogyakarta"
    case jawaTimur = "Jawa Timur"
    case bali = "Bali"
}
