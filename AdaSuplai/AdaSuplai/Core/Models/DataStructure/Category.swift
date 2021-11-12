//
//  Category.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 04/11/21.
//

import Foundation
import UIKit

// MARK: - InitialCategory
struct InitialCategory: Codable {
    let data: [Category]
}

// MARK: - Category
struct Category: Codable {
    let id, name, image: String
    let v: Int
    let isHome: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, isHome, image
        case v = "__v"
    }
}
