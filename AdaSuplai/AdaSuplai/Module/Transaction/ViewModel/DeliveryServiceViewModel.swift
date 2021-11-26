//
//  DeliveryServiceViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 15/11/21.
//

import Foundation
import Combine

class DeliveryServiceViewModel: BaseViewModel {
    var shipmentPrices = [ShipmentPrice]()
    
    init(with shipmentPrices: [ShipmentPrice]) {
        self.shipmentPrices = shipmentPrices
        super.init()
    }
}
