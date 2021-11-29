//
//  WishlistCategory.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 29/11/21.
//

import Foundation

struct WishlistCategory {
    let image: String
    let name: String
    let count: Int
}

class WishlistCategoryData {
    func getData() -> [WishlistCategory] {
        return [
            WishlistCategory(image: "", name: "Kopi", count: 3),
            WishlistCategory(image: "", name: "Dairy Product", count: 6),
            WishlistCategory(image: "", name: "Packaging Kopi", count: 4)
        ]
    }
}
