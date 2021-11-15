//
//  User.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 09/11/21.
//

import Foundation

struct User: Codable {
    var name = ""
    var email = ""
    var phoneNumber = ""
    var birthDate = ""
    var gender = ""
    var businessName = ""
    var businessCategory = ""
    var password = ""
    
    enum CodingKeys: String, CodingKey {
        case name, email, phoneNumber, birthDate, gender, businessName, businessCategory, password
    }
}
