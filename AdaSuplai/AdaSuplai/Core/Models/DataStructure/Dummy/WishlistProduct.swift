//
//  WishlistProduct.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 29/11/21.
//

import Foundation

struct WishlistProduct {
    let image: String
    let name: String
    let variant: String
    let price: Int
}

class WishlistProductData {
    func getData() -> [WishlistProduct] {
        return [
            WishlistProduct(image: "", name: "Biji Kopi Robusta", variant: "Dark Roast", price: 90_000),
            WishlistProduct(image: "", name: "Flores Manggarai Drip Coffee", variant: "Individual Pack", price: 15_000),
            WishlistProduct(image: "", name: "Fruity Series Coffee Beans 5 Kg", variant: "Gujji Ethiopia", price: 550_000),
            WishlistProduct(image: "", name: "Paper Cup Sleeve Polos 100 pcs", variant: "9 oz", price: 14_900)
        ]
    }
}
