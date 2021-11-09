//
//  HomeViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import Foundation
import Combine
import UIKit

class HomeViewModel: BaseViewModel {
    let productTrends = CurrentValueSubject<[Product], Never>([Product]())
    var suppliers = CurrentValueSubject<[Supplier], Never>([Supplier]())
    let service: RemoteDataService
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
                      category: "Teh")]
    
    override init() {
        self.service = RemoteDataService()
        super.init()
        self.fetchProductTrends()
    }
    
    private func fetchProductTrends() {
        Task {
            do {
                self.productTrends.value = try await service.getData([Product].self, url: .product)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchSupplier() {
        Task {
            do {
                self.suppliers.value = try await service.getData([Supplier].self, url: .supplier)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
