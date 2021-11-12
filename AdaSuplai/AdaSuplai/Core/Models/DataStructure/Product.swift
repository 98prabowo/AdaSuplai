//
//  Product.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 04/11/21.
//

import Foundation

struct Product: Codable {
    let id: String
    let supplier: Supplier
    let category: Category
    let etalase: String
    let brand: Brand
    let name, description, status, dimension: String
    let minOrder, neto, bruto, price: Int
    let stock: Int
    let unit, image: String
    let v, rating, sales: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case supplier = "supplier_id"
        case category = "category_id"
        case etalase = "etalase_id"
        case brand = "brand_id"
        case name
        case description
        case status, dimension
        case minOrder = "min_order"
        case neto, bruto, price, stock, unit, image
        case v = "__v"
        case rating, sales
    }
}
