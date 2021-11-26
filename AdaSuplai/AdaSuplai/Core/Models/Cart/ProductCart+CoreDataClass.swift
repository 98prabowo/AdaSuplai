//
//  ProductCart+CoreDataClass.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 26/11/21.
//
//

import Foundation
import CoreData

@objc(ProductCart)
public class ProductCart: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case image
        case quantity
        case minOrder
        case subtotal
        case notes
        case dimension
        case isMarked = "is_marked"
        case productID = "product_id"
        case productName = "product_name"
        case productPrice = "product_price"
        case productVariant = "product_variant"
        case supplierID = "supplier_id"
        case supplierName = "supplier_name"
        case cart
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.image = try container.decode(String.self, forKey: .image)
        self.quantity = try container.decode(Int64.self, forKey: .quantity)
        self.minOrder = try container.decode(Int64.self, forKey: .minOrder)
        self.dimension = try container.decode(String.self, forKey: .dimension)
        self.subtotal = try container.decode(Int64.self, forKey: .subtotal)
        self.notes = try container.decode(String.self, forKey: .notes)
        self.isMarked = try container.decode(Bool.self, forKey: .isMarked)
        self.productID = try container.decode(String.self, forKey: .productID)
        self.productName = try container.decode(String.self, forKey: .productName)
        self.productPrice = try container.decode(Int64.self, forKey: .productPrice)
        self.productVariant = try container.decode(String.self, forKey: .productVariant)
        self.supplierID = try container.decode(String.self, forKey: .supplierID)
        self.supplierName = try container.decode(String.self, forKey: .supplierName)
        self.cart = try container.decode(Cart.self, forKey: .cart)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(image, forKey: .image)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(minOrder, forKey: .minOrder)
        try container.encode(subtotal, forKey: .subtotal)
        try container.encode(notes, forKey: .notes)
        try container.encode(isMarked, forKey: .isMarked)
        try container.encode(productID, forKey: .productID)
        try container.encode(productName, forKey: .productName)
        try container.encode(productPrice, forKey: .productPrice)
        try container.encode(productVariant, forKey: .productVariant)
        try container.encode(supplierID, forKey: .supplierID)
        try container.encode(supplierName, forKey: .supplierName)
        try container.encode(cart, forKey: .cart)
    }
}
