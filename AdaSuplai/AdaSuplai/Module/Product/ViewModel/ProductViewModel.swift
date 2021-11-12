//
//  ProductViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import Foundation
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
}
