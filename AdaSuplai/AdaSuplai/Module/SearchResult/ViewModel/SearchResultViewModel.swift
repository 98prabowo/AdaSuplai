//
//  SearchResultViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 20/10/21.
//

import Foundation
import Combine

class SearchResultViewModel: BaseViewModel {
    let service: RemoteDataService
    let keyword: String
    let products = CurrentValueSubject<[Product], Never>([Product]())
    var subscribers = Set<AnyCancellable>()
    
    init(keyword: String) {
        self.keyword = keyword
        self.service = RemoteDataService()
        super.init()
        self.saveHistory()
        self.fetchProduct()
    }
    
    private func saveHistory() {
        guard let context = self.context else { return }
        let history = SearchHistory(context: context)
        history.searchKey = keyword
        history.date = Date(timeIntervalSinceNow: 0)
        self.saveData()
    }
    
    private func fetchProduct() {
        Task {
            do {
                self.products.value = try await service.getData([Product].self, url: .searchProduct, keyword: self.keyword)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
