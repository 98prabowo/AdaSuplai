//
//  AddToCartBottomSheetViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 09/11/21.
//

import Foundation
import CoreData

class AddToCartBottomSheetViewModel: BaseViewModel {
    let product: Product
    
    init(product: Product) {
        self.product = product
        super.init()
    }
    
    private func fetchCart() -> Cart? {
        guard let context = self.context else { return nil }
        var cart: Cart?
        do {
            let request = Cart.fetchRequest() as NSFetchRequest
            cart = try context.fetch(request).first
        } catch {
            print("Fetch cart in AddToCart error: \(error.localizedDescription)")
        }
        return cart
    }
    
    private func createProductCart(product: Product, quantity: Int) -> ProductCart? {
        guard let context = self.context else { return nil }
        let productCart = ProductCart(context: context)
        productCart.image = product.image
        productCart.productName = product.name
        productCart.productPrice = Int64(product.price)
        productCart.productID = product.id
        productCart.supplierID = product.supplier.id
        productCart.supplierName = product.supplier.supplierName
        productCart.quantity = Int64(quantity)
        productCart.subtotal = Int64(product.price * quantity)
        return productCart
    }
    
    private func getSameProduct(from cart: Cart, and product: Product) -> ProductCart? {
        if let cartProducts = cart.products?.allObjects as? [ProductCart] {
            for cartProduct in cartProducts where cartProduct.productID == product.id {
                return cartProduct
            }
        }
        return nil
    }
    
    private func getTotalPrice() -> Int64 {
        var result: Int64 = 0
        if let cart = self.fetchCart(),
           let products = cart.products?.allObjects as? [ProductCart] {
            for product in products {
                result += product.subtotal
            }
        }
        return result
    }
    
    func addToCartData(product: Product, quantity: Int) {
        guard let context = self.context,
              let productCart = self.createProductCart(product: product, quantity: quantity) else { return }
        
        if let cart = self.fetchCart() {
            if let sameProduct = self.getSameProduct(from: cart, and: product) {
                sameProduct.quantity += Int64(quantity)
                sameProduct.subtotal = Int64(product.price) * sameProduct.quantity
            } else {
                cart.addToProducts(productCart)
            }
            cart.totalPrice = self.getTotalPrice()
            self.saveData()
        } else {
            let cart = Cart(context: context)
            cart.addToProducts(productCart)
            cart.totalPrice = self.getTotalPrice()
            self.saveData()
        }
    }
}
