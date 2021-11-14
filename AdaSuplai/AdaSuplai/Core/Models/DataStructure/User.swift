//
//  User.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 09/11/21.
//

import Foundation

struct User: Codable {
    var name = "", email = "", phoneNumber = "", birthDate = ""
    var gender = "", businessName = "", businessCategory = "", password = ""
    
    enum CodingKeys: String, CodingKey {
            case name, email, phoneNumber, birthDate, gender, businessName, businessCategory, password
        }
}

struct Login: Codable {
    var phoneNumber, password: String
}
