//
//  Cart+CoreDataClass.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 12/11/21.
//
//

import Foundation
import CoreData

@objc(Cart)
public class Cart: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case totalPrice = "total_price"
        case products
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totalPrice = try container.decode(Int64.self, forKey: .totalPrice)
        self.products = try container.decode(Set<ProductCart>.self, forKey: .products) as NSSet
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(totalPrice, forKey: .totalPrice)
        guard let products = products as? Set<ProductCart> else {
            throw DecoderConfigurationError.formatDataFalse
        }
        try container.encode(products, forKey: .products)
    }
}
