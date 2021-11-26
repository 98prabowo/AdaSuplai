//
//  Profile.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 19/11/21.
//

import Foundation

// MARK: - UpdateProfileResponse
struct UpdateProfileResponse: Codable {
    let message, name, profilePicture, businessName: String
    let gender, id, birthDate, businessCategory: String
    let phoneNumber, email: String

    enum CodingKeys: String, CodingKey {
        case message, name, profilePicture, businessName, gender
        case id = "_id"
        case birthDate, businessCategory, phoneNumber, email
    }
}

// MARK: - AddressTemp
struct AddressTemp: Codable {
    var addressName, province, city, district: String
    var subdivision, postalCode, userId, id: String

    enum CodingKeys: String, CodingKey {
        case addressName, province, city, district, subdivision, postalCode
        case userId
        case id = "_id"
    }
}
