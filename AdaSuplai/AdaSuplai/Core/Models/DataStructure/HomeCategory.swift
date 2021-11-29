//
//  Category.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 13/10/21.
//

import Foundation
import UIKit

struct HomeCategory {
    let image: UIImage?
    let category: String
    let id: String
}

class HomeCategoryData {
    func getHomeCategories() -> [HomeCategory] {
        let categories: [HomeCategory] = [
            HomeCategory(image: UIImage(named: "Kopi"),
                         category: "Biji Kopi", id: "6184f412a17159dd3f73adef"),
            HomeCategory(image: UIImage(named: "Sirup"),
                         category: "Sirup", id: "6184f435a17159dd3f73adf1"),
            HomeCategory(image: UIImage(named: "Susu"),
                         category: "Susu", id: "6184f50ca17159dd3f73adf8"),
            HomeCategory(image: UIImage(named: "Bubuk"),
                         category: "Bubuk", id: "6184f5b1a17159dd3f73adfb"),
            HomeCategory(image: UIImage(named: "Es Batu"),
                         category: "Es Batu", id: "6184f5d3a17159dd3f73adff"),
            HomeCategory(image: UIImage(named: "Gula"),
                         category: "Gula", id: "6184fa8da17159dd3f73ae03"),
            HomeCategory(image: UIImage(named: "Kemasan"),
                         category: "Kemasan", id: "6184fab7a17159dd3f73ae07"),
            HomeCategory(image: UIImage(named: "Lihat Lebih"),
                         category: "Teh", id: "6184fac8a17159dd3f73ae0b")]
        return categories
    }
}
