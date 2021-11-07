//
//  CategoryViewModel.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 20/10/21.
//

import Foundation
import UIKit

class CategoryViewModel: BaseViewModel {
    var categoryData: Observable<[Category]> = Observable([])
    var allCategoryData: Observable<[Category]> = Observable([])
    
    func fetchCategory() {
        let url = URL(string: "https://adasuplai-api-env-staging.herokuapp.com/category/fetch")!
        URLSession.shared.fetchDataCategory(at: url) { result in
            switch result {
            case .success(let data):
                self.categoryData.value = data
                self.allCategoryData.value = data
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
}
