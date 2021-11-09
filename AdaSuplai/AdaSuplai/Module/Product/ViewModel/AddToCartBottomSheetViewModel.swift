//
//  AddToCartBottomSheetViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 09/11/21.
//

import Foundation

class AddToCartBottomSheetViewModel: BaseViewModel {
    let product: Product
    
    init(product: Product) {
        self.product = product
        super.init()
    }
}
