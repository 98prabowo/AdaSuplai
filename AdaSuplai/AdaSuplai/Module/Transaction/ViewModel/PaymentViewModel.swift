//
//  PaymentViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 15/11/21.
//

import Foundation
import Combine

class PaymentViewModel: BaseViewModel {
    let service = RemoteDataService()
    var paymentMethods = CurrentValueSubject<[Payment], Never>([Payment]())
    var paymentCategories = [String]()
    
    override init() {
        super.init()
        self.fetchPaymentMethod()
    }
    
    private func fetchPaymentMethod() {
        Task {
            do {
                self.paymentMethods.value = try await service.getData([Payment].self, url: .paymentMethod)
            } catch {
                print("Fetch paymentMethod in Payment error: \(error.localizedDescription)")
            }
        }
    }
    
    func getPaymentCategories() {
        for paymentMethod in self.paymentMethods.value
        where !self.paymentCategories.contains(paymentMethod.paymentType) {
            self.paymentCategories.append(paymentMethod.paymentType)
        }
    }
    
    func getPaymentMethodPerCategories(with category: String) -> [Payment] {
        var result = [Payment]()
        for payment in self.paymentMethods.value
        where payment.paymentType == category {
            result.append(payment)
        }
        return result
    }
    
    func getPaymentCountPerCategories(with category: String) -> Int {
        let paymentMethods = self.getPaymentMethodPerCategories(with: category)
        return paymentMethods.count
    }
}
