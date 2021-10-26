//
//  MoreSortFilterCategoryViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 25/10/21.
//

import Foundation
import Combine

class MoreSortFilterCategoryViewModel: BaseViewModel {
    var keys: [String]
    var tablePublisher = PassthroughSubject<Void, Never>()
    var filteredKeys: [String] {
        didSet {
            self.tablePublisher.send()
        }
    }
    
    init(keys: [String]) {
        self.keys = keys
        self.filteredKeys = keys
        super.init()
    }
}
