//
//  CategoryViewModel.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 20/10/21.
//

import Foundation
import UIKit

class CategoryViewModel: BaseViewModel {
    let service = RemoteDataService()
    var categoryData: Observable<[Category]> = Observable([])
    var allCategoryData: Observable<[Category]> = Observable([])
    var categoryProduct: Observable<[Product]> = Observable([])
    
    override init() {
        super.init()
        self.fetchCategory()
    }
    
    func fetchCategory() {
        Task {
            do {
                let parent = try await service.getData(InitialCategory.self, url: .category)
                self.categoryData.value = parent.data
                self.allCategoryData.value = parent.data
            } catch {
                print("Fetch Category in CategoryViewModel error: \(error.localizedDescription)")
            }
        }
//        let url = URL(string: "https://adasuplai-api-env-staging.herokuapp.com/category/fetch")!
//        URLSession.shared.fetchDataCategory(at: url) { result in
//            switch result {
//            case .success(let data):
//                self.categoryData.value = data
//                self.allCategoryData.value = data
//            case .failure(let error):
//                print("\(error)")
//            }
//        }
    }
    
    func fetchCategoryProduct(id: String, myComplete:@escaping(Bool) -> Void) {
        Task {
            do {
                self.categoryProduct.value = try await service.getData([Product].self, url: .searchProductByCategoryID, keyword: id)
                myComplete(true)
            } catch {                                                                           
                print(error)
                myComplete(false)
            }
        }
    }
    
}
