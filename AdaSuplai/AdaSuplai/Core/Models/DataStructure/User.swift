//
//  User.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 09/11/21.
//

import Foundation

// MARK: - InitialUser
struct InitialUser: Codable {
    let message: String
    let data: User
}

// MARK: - User
struct User: Codable {
    let id, name, birthDate, gender: String
    let businessName, businessCategory, phoneNumber, email: String
    let password, date: String
    let v: Int
    let profilePicture: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, birthDate, gender, businessName, businessCategory, phoneNumber, email, password, date
        case v = "__v"
        case profilePicture
    }
}
