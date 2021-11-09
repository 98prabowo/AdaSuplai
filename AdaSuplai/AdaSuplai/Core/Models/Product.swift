//
//  Product.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 04/11/21.
//

import Foundation

struct Product: Codable {
    let id: String
        let supplierID: Supplier
        let etalaseID, name, description, status: String
        let dimension: String
        let minOrder, neto, bruto, price: Int
        let stock: Int
        let unit, image: String
        let v: Int
        let brandID: Brand
        let rating, sales: Int

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case supplierID = "supplier_id"
            case etalaseID = "etalase_id"
            case name
            case description
            case status, dimension
            case minOrder = "min_order"
            case neto, bruto, price, stock, unit, image
            case v = "__v"
            case brandID = "brand_id"
            case rating, sales
        }
}
