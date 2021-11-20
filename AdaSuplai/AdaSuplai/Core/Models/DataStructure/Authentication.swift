//
//  Authentication.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 15/11/21.
//

import Foundation

// MARK: - Parameter Model
// MARK: - Register
struct Register: Codable {
    var name = "", email = "", phoneNumber = "", birthDate = ""
    var gender = "", businessName = "", businessCategory = "", password = ""
    
    enum CodingKeys: String, CodingKey {
            case name, email, phoneNumber, birthDate, gender, businessName, businessCategory, password
        }
}

// MARK: - Login
struct Login: Codable {
    var phoneNumber, password: String
}

// MARK: - Empty
struct Empty: Codable {
    
}

// MARK: - VerifyOTP
struct VerifyOTP: Codable {
    let phoneNumber, otp: String
}

// MARK: - Generate OTP
struct GenerateOTP: Codable {
    let phoneNumber: String
}

// MARK: - Response Data
// MARK: - LoginData
struct LoginData: Codable {
    let id, name, birthDate, gender: String
    let businessName, businessCategory, phoneNumber, email: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, birthDate, gender, businessName, businessCategory, phoneNumber, email
    }
}
