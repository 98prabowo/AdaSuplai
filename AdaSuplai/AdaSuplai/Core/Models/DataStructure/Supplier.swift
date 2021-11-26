//
//  Supplier.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/11/21.
//

import Foundation

struct Supplier: Codable {
    let id, supplierName: String
    let address: [String]?
    var products: [TransactionProduct]?
    var shipmentPrice: ShipmentPrice?
    let v: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case supplierName = "supplier_name"
        case shipmentPrice = "shipment_price"
        case address, products
        case v = "__v"
    }
}
