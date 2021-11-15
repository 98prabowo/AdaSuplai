//
//  ProductViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import Foundation
import CoreData
import Combine

class ProductViewModel: BaseViewModel {
    let product: Product
    let service: RemoteDataService
    var similarProducts = CurrentValueSubject<[Product], Never>([Product]())
    var suppliers = [Supplier]()
    
    init(product: Product) {
        self.product = product
        self.service = RemoteDataService()
        super.init()
        Task {
            await self.getSimilarProduct(by: product.category.id)
        }
    }
    
    private func getSimilarProduct(by categoryID: String) async {
        do {
            self.similarProducts.value = try await service.getData([Product].self, url: .searchProductByCategoryID, keyword: categoryID)
            self.cleanSimilarProduct()
        } catch {
            print("Fetch product in Product error: \(error.localizedDescription)")
        }
    }
    
    private func cleanSimilarProduct() {
        for (index, product) in self.similarProducts.value.enumerated()
        where product.id == self.product.id {
            self.similarProducts.value.remove(at: index)
        }
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
        productCart.isMarked = true
        return productCart
    }
    
    private func getTotalPrice(from cart: Cart) -> Int64 {
        var result: Int64 = 0
        if let products = cart.products?.allObjects as? [ProductCart] {
            for product in products {
                result += product.subtotal
            }
        }
        return result
    }
    
    func getCartData(product: Product, quantity: Int) -> Cart? {
        if let context = self.context,
           let productCart = self.createProductCart(product: product, quantity: quantity),
           let entity = NSEntityDescription.entity(forEntityName: "Cart", in: context) {
            let cart = Cart(entity: entity, insertInto: nil)
            cart.addToProducts(productCart)
            cart.totalPrice = self.getTotalPrice(from: cart)
            return cart
        }
        return nil
    }
}
