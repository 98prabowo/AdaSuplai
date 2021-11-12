//
//  Cart+CoreDataProperties.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 12/11/21.
//
//

import Foundation
import CoreData

extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var totalPrice: Int64
    @NSManaged public var products: NSSet?

}

// MARK: Generated accessors for products
extension Cart {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: ProductCart)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: ProductCart)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

extension Cart: Identifiable {

}
