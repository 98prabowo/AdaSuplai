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
