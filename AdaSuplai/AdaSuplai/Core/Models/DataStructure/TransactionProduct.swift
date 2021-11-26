//
//  TransactionProduct.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 25/11/21.
//

import Foundation

struct TransactionProduct: Codable {
    let id: String
    let name, dimension: String
    let price: Int
    let image: String
    var quantity: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case dimension, quantity
        case price, image
    }
}
