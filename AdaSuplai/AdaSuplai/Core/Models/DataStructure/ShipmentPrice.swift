//
//  ShipmentPrice.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 24/11/21.
//

import Foundation

struct ShipmentPrice: Codable {
    let logistic: Logistic
    let rate: Rate
    let weight: Double
    let volume: Int
    let volumeWeight: Double
    let finalWeight, minDay, maxDay, unitPrice: Int
    let totalPrice: Int
    let discount: Double
    let discountValue, discountedPrice, insuranceFee: Int
    let mustUseInsurance: Bool
    let liabilityValue, finalPrice: Int
    let currency: Currency
    let insuranceApplied: Bool
    var createdDate: Date?

    enum CodingKeys: String, CodingKey {
        case logistic, rate, weight, volume
        case volumeWeight = "volume_weight"
        case finalWeight = "final_weight"
        case minDay = "min_day"
        case maxDay = "max_day"
        case unitPrice = "unit_price"
        case totalPrice = "total_price"
        case discount
        case discountValue = "discount_value"
        case discountedPrice = "discounted_price"
        case insuranceFee = "insurance_fee"
        case mustUseInsurance = "must_use_insurance"
        case liabilityValue = "liability_value"
        case finalPrice = "final_price"
        case currency
        case insuranceApplied = "insurance_applied"
        case createdDate = "created_date"
    }
}

enum Currency: String, Codable {
    case idr = "IDR"
}

enum TypeEnum: String, Codable {
    case express = "Express"
    case regular = "Regular"
    case trucking = "Trucking"
}
