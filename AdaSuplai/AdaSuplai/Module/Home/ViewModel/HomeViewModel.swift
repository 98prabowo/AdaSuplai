//
//  HomeViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import Foundation
import UIKit

class HomeViewModel: BaseViewModel {
    let categories: [DummyCategory] = [
        DummyCategory(image: UIImage(named: "Kopi"),
                      category: "Biji Kopi"),
        DummyCategory(image: UIImage(named: "Sirup"),
                      category: "Sirup"),
        DummyCategory(image: UIImage(named: "Susu"),
                      category: "Susu"),
        DummyCategory(image: UIImage(named: "Bubuk"),
                      category: "Bubuk"),
        DummyCategory(image: UIImage(named: "Es Batu"),
                      category: "Es Batu"),
        DummyCategory(image: UIImage(named: "Gula"),
                      category: "Gula"),
        DummyCategory(image: UIImage(named: "Kemasan"),
                      category: "Kemasan"),
        DummyCategory(image: UIImage(named: "Lihat Lebih"),
                      category: "Lihat Lebih")]
    
    let todayTrends: [DummyProduct] = [
        DummyProduct(productName: "Gula Pasir Tanpa Pemutih Pack Karung",
                     image: UIImage(named: "gula_2"),
                     rating: 4.7,
                     productSold: 300,
                     location: "Madura",
                     minimumOrder: "50 Kg",
                     realPrice: 510_000,
                     uomPrice: "50 Kg",
                     discount: 2),
        DummyProduct(productName: "Bubuk Pure Matcha Impor Jepang",
                     image: UIImage(named: "matcha_powder"),
                     rating: 4.7,
                     productSold: 300,
                     location: "Surabaya",
                     minimumOrder: "5 Kg",
                     realPrice: 355_000,
                     uomPrice: "5 Kg",
                     discount: 1.5),
        DummyProduct(productName: "Biji Kopi Pak Gundul",
                     image: UIImage(named: "coffee_2"),
                     rating: 4.7,
                     productSold: 300,
                     location: "Lumajang",
                     minimumOrder: "50 Kg",
                     realPrice: 510_000,
                     uomPrice: "50 Kg",
                     discount: 2)
    ]
}
