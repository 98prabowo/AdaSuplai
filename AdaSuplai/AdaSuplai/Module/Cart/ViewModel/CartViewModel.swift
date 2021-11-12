//
//  CartViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 10/11/21.
//

import Foundation
import Combine
import CoreData
import SwiftUI

typealias SupplierCart = (id: String, name: String)

class CartViewModel: BaseViewModel {
    let service = RemoteDataService()
    var cart = CurrentValueSubject<Cart, Never>(Cart())
//    var products = CurrentValueSubject<[Product], Never>([Product]())
    var suppliers = [SupplierCart]()
    
    private func fetchCart() {
        guard let context = self.context else { return }
        do {
            let request = Cart.fetchRequest() as NSFetchRequest
            if let cart = try context.fetch(request).first {
                self.cart.value = cart
            }
        } catch {
            print("Fetch Cart in CartViewModel error: \(error.localizedDescription)")
        }
    }
    
//    func getProduct() async {
//        guard let products = self.cart.value.products,
//              let productArray = products.allObjects as? [ProductCart] else { return }
//        var productsTemp = [Product]()
//        for product in productArray {
//            if let id = product.productID,
//               let product = await self.fetchProduct(by: id) {
//                productsTemp.append(product)
//            }
//        }
//        self.products.value = productsTemp.sorted { $0.id < $1.id }
//    }
//
//    private func fetchProduct(by id: String) async -> Product? {
//        do {
//            let product = try await self.service.getData(Product.self, url: .searchProductByID, keyword: id)
//            return product
//        } catch {
//            print("Fetch Product in CartViewModel error: \(error.localizedDescription)")
//        }
//        return nil
//    }
    
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
//        Task {
//            await self.getProduct()
//        }
    }
    
    func removeProduct() {
        if let productCarts = self.cart.value.products?.allObjects as? [ProductCart] {
            for productCart in productCarts
            where productCart.isMarked {
                self.deleteData(productCart)
            }
            self.cleanSupplierData()
            self.reloadData()
        }
    }
    
    func getSupplier() {
        if let productCarts = self.cart.value.products?.allObjects as? [ProductCart] {
            for product in productCarts {
                let supplierIDs = suppliers.map { $0.id }
                if let supplierID = product.supplierID,
                   let supplierName = product.supplierName,
                   !supplierIDs.contains(supplierID) {
                    let supplier = (supplierID, supplierName)
                    self.suppliers.append(supplier)
                }
            }
            self.cleanSupplierData()
        }
    }
    
    func getProductPerSection(with supplierID: String) -> [ProductCart] {
        var products = [ProductCart]()
        if let productCarts = self.cart.value.products?.allObjects as? [ProductCart] {
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
        if let productCarts = self.cart.value.products?.allObjects as? [ProductCart],
           !productCarts.isEmpty {
            result = false
        }
        return result
    }
    
//    func getQuantity(of product: Product) -> Int {
//        var result: Int = 0
//        if let productCarts = self.cart.value.products,
//           let productArray = productCarts.allObjects as? [ProductCart] {
//            for productInCart in productArray
//            where productInCart.productID == product.id {
//                result = Int(productInCart.quantity)
//            }
//        }
//        return result
//    }
    
    // MARK: Price Data
    func setSubTotalPrice(from product: ProductCart) {
        if let products = self.cart.value.products?.allObjects as? [ProductCart] {
            for productCart in products
            where productCart.productID == product.productID {
                productCart.subtotal = product.productPrice * Int64(product.quantity)
                productCart.quantity = Int64(product.quantity)
                self.saveData()
            }
        }
        self.setTotalPrice()
        self.fetchCart()
    }
    
    private func setTotalPrice() {
        var result: Int64 = 0
        if let products = self.cart.value.products?.allObjects as? [ProductCart] {
            for product in products {
                result += product.subtotal
            }
            cart.value.totalPrice = result
            self.saveData()
        }
    }
    
    func getViewTotalPrice() -> Int {
        var result: Int = 0
//        if let products = self.cart.value.products?.allObjects as? [ProductCart] {
//            for product in products
//            where product.isMarked {
//                result += Int(product.productPrice * product.quantity)
//            }
//        }
        return result
    }
    
    // MARK: Checkmark Data
    func isAllProductMarked() -> Bool {
        var result: Bool = true
        if let productCarts = self.cart.value.products?.allObjects as? [ProductCart] {
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
        
//        if let productCarts = self.cart.value.products?.allObjects as? [ProductCart] {
//            for product in products {
//                for productCart in productCarts
//                where product.id == productCart.productID &&
//                      !productCart.isMarked {
//                    result = false
//                }
//            }
//        }
        return result
    }
    
//    func isProductMarked(_ product: Product) -> Bool {
//        var result: Bool = false
//        if let productCarts = self.cart.value.products?.allObjects as? [ProductCart] {
//            for productCart in productCarts
//            where productCart.productID == product.id &&
//                  productCart.isMarked {
//                result = true
//            }
//        }
//        return result
//    }
    
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
        if let productCarts = self.cart.value.products?.allObjects as? [ProductCart] {
            for product in productCarts
            where product.supplierID == supplierID {
                self.checkedProduct(product)
            }
        }
    }
    
    func uncheckedSupplier(_ supplierID: String) {
        if let productCarts = self.cart.value.products?.allObjects as? [ProductCart] {
            for product in productCarts
            where product.supplierID == supplierID {
                self.uncheckedProduct(product)
            }
        }
    }
    
    func checkedProduct(_ product: ProductCart) {
        product.isMarked = true
        self.saveData()
//        if let cartProducts = self.cart.value.products?.allObjects as? [ProductCart] {
//            for cartProduct in cartProducts
//            where cartProduct.productID == product.id {
//                cartProduct.isMarked = true
//                self.saveData()
//            }
//        }
    }
    
    func uncheckedProduct(_ product: ProductCart) {
        product.isMarked = false
        self.saveData()
//        if let cartProducts = self.cart.value.products?.allObjects as? [ProductCart] {
//            for cartProduct in cartProducts
//            where cartProduct.productID == product.id {
//                cartProduct.isMarked = false
//                self.saveData()
//            }
//        }
    }
    
    func dataCheck() {
        if let cartProducts = self.cart.value.products?.allObjects as? [ProductCart] {
            var counter = 0
            let checks = cartProducts.map { $0.isMarked }
            for checked in checks
            where checked {
                counter += 1
            }
            print(counter)
        }
    }
}
