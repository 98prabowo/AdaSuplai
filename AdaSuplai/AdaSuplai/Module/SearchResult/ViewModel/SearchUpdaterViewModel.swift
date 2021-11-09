//
//  SearchUpdaterViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 20/10/21.
//

import Foundation
import CoreData

class SearchUpdaterViewModel: BaseViewModel {
    var keyword = ""
    var searchHistory = [SearchHistory]()
    
    override init() {
        super.init()
        self.fetchSearchHistory()
    }
    
    func fetchSearchHistory() {
        guard let context = self.context else { return }
        do {
            let request: NSFetchRequest<SearchHistory> = SearchHistory.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
            request.fetchLimit = 5
            let history = try context.fetch(request)
            self.searchHistory = history.sorted(by: { prev, after in
                guard let prev = prev.date,
                let after = after.date else { return false }
                return prev > after
            })
        } catch {
            print("Fetch error: \(error.localizedDescription)")
        }
    }
}
