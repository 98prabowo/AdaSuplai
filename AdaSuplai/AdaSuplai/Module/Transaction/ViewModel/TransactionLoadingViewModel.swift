//
//  TransactionLoadingViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 29/11/21.
//

import Foundation
import CoreData
import Combine

class TransactionLoadingViewModel: BaseViewModel {
    let service: RemoteDataService
    let transaction: Transaction
    var cart = [Cart]()
    var transactionResponse = CurrentValueSubject<[TransactionResponse], Never>([TransactionResponse]())
    
    init(with transaction: Transaction) {
        self.service = RemoteDataService()
        self.transaction = transaction
        super.init()
        self.fetchCart()
    }
    
    private func fetchCart() {
        guard let context = self.context else { return }
        do {
            let request = Cart.fetchRequest() as NSFetchRequest
            self.cart = try context.fetch(request)
        } catch {
            print("Fetch Cart in CartViewModel error: \(error.localizedDescription)")
        }
    }
    
    private func createTransactionTemp() -> TransactionTemp? {
        if let userID = UserDefaults().string(forKey: "userId"),
           let payment = transaction.payment,
           let supplier = self.transaction.suppliers?.first,
           let shipperData = supplier.shipmentPrice,
           let items = supplier.products {
            return TransactionTemp(userID: userID,
                                   supplierID: supplier.id,
                                   shipperData: shipperData,
                                   items: items,
                                   bankCode: payment.code)
        }
        return nil
    }
    
    func postTransaction() {
        if let transactionTemp = self.createTransactionTemp() {
            Task {
                do {
                    let transactionResponse = try await service.postData(url: .createOrder, parameter: transactionTemp)
                    let response = try JSONDecoder().decode(TransactionResponse.self, from: transactionResponse)
                    self.transactionResponse.value = [response]
                    
                    print(self.transactionResponse.value)
                    
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("Post data in TransactionLoading error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func deleteCartData() {
        if let products = self.cart.first?.products?.allObjects as? [ProductCart] {
            for product in products
            where product.isMarked {
                self.deleteData(product)
            }
        }
    }
}
