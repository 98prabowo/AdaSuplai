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
            WishlistCategory(image: "kopiGroup", name: "Kopi", count: 3),
            WishlistCategory(image: "dairy", name: "Dairy Product", count: 6),
            WishlistCategory(image: "packaging", name: "Packaging Kopi", count: 4)
        ]
    }
}
