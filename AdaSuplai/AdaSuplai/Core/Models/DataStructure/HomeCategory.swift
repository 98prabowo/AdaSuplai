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
}

class HomeCategoryData {
    func getHomeCategories() -> [HomeCategory] {
        let categories: [HomeCategory] = [
            HomeCategory(image: UIImage(named: "Kopi"),
                          category: "Biji Kopi"),
            HomeCategory(image: UIImage(named: "Sirup"),
                          category: "Sirup"),
            HomeCategory(image: UIImage(named: "Susu"),
                          category: "Susu"),
            HomeCategory(image: UIImage(named: "Bubuk"),
                          category: "Bubuk"),
            HomeCategory(image: UIImage(named: "Es Batu"),
                          category: "Es Batu"),
            HomeCategory(image: UIImage(named: "Gula"),
                          category: "Gula"),
            HomeCategory(image: UIImage(named: "Kemasan"),
                          category: "Kemasan"),
            HomeCategory(image: UIImage(named: "Lihat Lebih"),
                          category: "Teh")]
        return categories
    }
}
