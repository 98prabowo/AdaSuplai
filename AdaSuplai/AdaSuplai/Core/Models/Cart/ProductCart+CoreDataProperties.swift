//
//  ProductCart+CoreDataProperties.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 12/11/21.
//
//

import Foundation
import CoreData

extension ProductCart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductCart> {
        return NSFetchRequest<ProductCart>(entityName: "ProductCart")
    }

    @NSManaged public var isMarked: Bool
    @NSManaged public var productID: String?
    @NSManaged public var quantity: Int64
    @NSManaged public var subtotal: Int64
    @NSManaged public var supplierID: String?
    @NSManaged public var supplierName: String?
    @NSManaged public var image: String?
    @NSManaged public var productName: String?
    @NSManaged public var productPrice: Int64
    @NSManaged public var productVariant: String?
    @NSManaged public var notes: String?
    @NSManaged public var cart: Cart?

}

extension ProductCart: Identifiable {

}
