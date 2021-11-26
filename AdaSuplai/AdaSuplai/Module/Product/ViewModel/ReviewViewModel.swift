//
//  ReviewViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 26/11/21.
//

import Foundation

class ReviewViewModel: BaseViewModel {
    let reviews: [Review]
    
    init(with reviews: [Review]) {
        self.reviews = reviews
        super.init()
    }
}
