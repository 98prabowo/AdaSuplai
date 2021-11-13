//
//  TransactionViewModel.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 12/10/21.
//

import Foundation
import Combine
import CoreData

class TransactionViewModel: BaseViewModel {
    var cart = CurrentValueSubject<[Cart], Never>([Cart]())
    var suppliers = [Supplier]()
    
    override init() {
        super.init()
        self.fetchCart()
    }
    
    private func fetchCart() {
        guard let context = self.context else { return }
        do {
            let request = Cart.fetchRequest() as NSFetchRequest
            self.cart.value = try context.fetch(request)
        } catch {
            print("Fetch Cart in CartViewModel error: \(error.localizedDescription)")
        }
    }
    
    // MARK: Communication Data
    func reloadData() {
        self.fetchCart()
    }
    
    func getSupplier() {
        if let productCarts = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            for product in productCarts {
                let supplierIDs = suppliers.map { $0.id }
                if let supplierID = product.supplierID,
                   let supplierName = product.supplierName,
                   !supplierIDs.contains(supplierID) {
                    let supplier = Supplier(id: supplierID, supplierName: supplierName, address: nil, delivery: nil, v: nil)
                    self.suppliers.append(supplier)
                }
            }
        }
    }
    
    func getProductPerSection(with supplierID: String) -> [ProductCart] {
        var products = [ProductCart]()
        if let productCarts = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            for product in productCarts
            where product.supplierID == supplierID && product.isMarked {
                products.append(product)
            }
            
            products = products.sorted { prev, after in
                guard let prev = prev.productID else { return false }
                guard let after = after.productID else { return false }
                return prev < after
            }
        }
        return products
    }
    
    func getProductCountPerSection(with supplierID: String) -> Int {
        let products = self.getProductPerSection(with: supplierID)
        return products.count
    }
    
    func getTotalProductPricePerSection(with supplierID: String) -> Int {
        var result: Int = 0
        let products = self.getProductPerSection(with: supplierID)
        for product in products {
            result += Int(product.productPrice * product.quantity)
        }
        return result
    }
    
    func getTotalProductPrice() -> Int {
        var result: Int = 0
        if let products = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            for product in products
            where product.isMarked {
                result += Int(product.productPrice * product.quantity)
            }
        }
        return result
    }
}
