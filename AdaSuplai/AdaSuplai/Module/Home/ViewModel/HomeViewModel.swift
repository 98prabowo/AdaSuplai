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
    let service: RemoteDataService
    let categories: [HomeCategory]
    let banners: [Banner]
    
    override init() {
        self.service = RemoteDataService()
        self.categories = HomeCategoryData().getHomeCategories()
        self.banners = BannerData().getBannerData()
        super.init()
        self.fetchProductTrends()
    }
    
    private func fetchProductTrends() {
        Task {
            do {
                self.productTrends.value = try await service.getData([Product].self, url: .product)
            } catch {
                print("Fetch products in home errror: \(error.localizedDescription)")
            }
        }
    }
}
