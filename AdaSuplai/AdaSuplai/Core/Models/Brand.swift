//
//  Brand.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 09/11/21.
//

import Foundation

struct Brand: Codable {
    let id, brand: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case brand
    }
}
