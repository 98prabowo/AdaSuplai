//
//  CartViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 10/11/21.
//

import Foundation
import Combine
import CoreData

class CartViewModel: BaseViewModel {
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
    
    private func cleanSupplierData() {
        for (index, supplier) in self.suppliers.enumerated() {
            let products = self.getProductPerSection(with: supplier.id)
            if products.isEmpty {
                self.suppliers.remove(at: index)
            }
        }
    }
    
    // MARK: Communication Data
    func reloadData() {
        self.fetchCart()
    }
    
    func removeProduct() {
        if let productCarts = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            for productCart in productCarts
            where productCart.isMarked {
                self.deleteData(productCart)
            }
            self.cleanSupplierData()
            self.reloadData()
        }
    }
    
    func getSupplier() {
        if let productCarts = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            for product in productCarts {
                let supplierIDs = suppliers.map { $0.id }
                if let supplierID = product.supplierID,
                   let supplierName = product.supplierName,
                   !supplierIDs.contains(supplierID) {
                    let supplier = Supplier(id: supplierID, supplierName: supplierName, address: nil, v: nil)
                    self.suppliers.append(supplier)
                }
            }
            self.cleanSupplierData()
        }
    }
    
    func getProductPerSection(with supplierID: String) -> [ProductCart] {
        var products = [ProductCart]()
        if let productCarts = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            for product in productCarts
            where product.supplierID == supplierID {
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
    
    func isNoProduct() -> Bool {
        var result: Bool = true
        if let productCarts = self.cart.value.first?.products?.allObjects as? [ProductCart],
           !productCarts.isEmpty {
            result = false
        }
        return result
    }
    
    func isBuyEnable() -> Bool {
        var result: Bool = false
        if let productCarts = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            for productCart in productCarts
            where productCart.isMarked {
                result = true
            }
        }
        return result
    }
    
    // MARK: Price Data
    func setSubTotalPrice(from product: ProductCart, and quantity: Int) {
        if let products = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            for productCart in products
            where productCart.productID == product.productID {
                productCart.subtotal = product.productPrice * Int64(quantity)
                productCart.quantity = Int64(quantity)
                self.saveData()
            }
        }
        self.setTotalPrice()
        self.fetchCart()
    }
    
    private func setTotalPrice() {
        var result: Int64 = 0
        if let products = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            for product in products {
                result += product.subtotal
            }
            self.cart.value.first?.totalPrice = result
            self.saveData()
        }
    }
    
    func getViewTotalPrice() -> Int {
        var result: Int = 0
        if let products = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            for product in products
            where product.isMarked {
                result += Int(product.productPrice * product.quantity)
            }
        }
        return result
    }
    
    // MARK: Checkmark Data
    func isAllProductMarked() -> Bool {
        var result: Bool = true
        if let productCarts = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            if productCarts.isEmpty {
                result = false
            }
            
            for productCart in productCarts
            where !productCart.isMarked {
                result = false
            }
        }
        return result
    }
    
    func isAllProductInSectionMarked(_ supplierID: String) -> Bool {
        var result: Bool = true
        let products = self.getProductPerSection(with: supplierID)
        for product in products
        where !product.isMarked {
            result = false
        }
        return result
    }
    
    func checkedAll() {
        for supplier in suppliers {
            self.checkedSupplier(supplier.id)
        }
    }
    
    func uncheckedAll() {
        for supplier in suppliers {
            uncheckedSupplier(supplier.id)
        }
    }
    
    func checkedSupplier(_ supplierID: String) {
        if let productCarts = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            for product in productCarts
            where product.supplierID == supplierID {
                self.checkedProduct(product)
            }
        }
    }
    
    func uncheckedSupplier(_ supplierID: String) {
        if let productCarts = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            for product in productCarts
            where product.supplierID == supplierID {
                self.uncheckedProduct(product)
            }
        }
    }
    
    func checkedProduct(_ product: ProductCart) {
        product.isMarked = true
        self.saveData()
    }
    
    func uncheckedProduct(_ product: ProductCart) {
        product.isMarked = false
        self.saveData()
    }
}
