//
//  ProductViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import Foundation

class ProductViewModel: BaseViewModel {
    let product: Product
    var suppliers = [Supplier]()
    
    init(product: Product) {
        self.product = product
    }
    
}
