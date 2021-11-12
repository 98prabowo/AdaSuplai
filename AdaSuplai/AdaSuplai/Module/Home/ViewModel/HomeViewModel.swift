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
    var categories = [HomeCategory]()
    
    override init() {
        self.service = RemoteDataService()
        self.categories = HomeCategoryData().getHomeCategories()
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
