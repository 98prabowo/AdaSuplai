//
//  WaitingPaymentViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 16/11/21.
//

import Foundation
import Combine

typealias SimpleInstruction = (instructions: [String], method: String)

class WaitingPaymentViewModel: BaseViewModel {
    let service: RemoteDataService
    let transaction: TransactionResponse
    let payment: Payment
    var paymentInstructions = CurrentValueSubject<[SimpleInstruction], Never>([SimpleInstruction]())
    
    init(with transaction: TransactionResponse, and payment: Payment) {
        self.service = RemoteDataService()
        self.transaction = transaction
        self.payment = payment
        super.init()
        self.fetchPaymentInstructions()
    }
    
    private func fetchPaymentInstructions() {
        Task {
            do {
                let instructions = try await self.service.getData([PaymentInstructions].self, url: .paymentInstruction)
                self.paymentInstructions.value = self.getSpecificInstruction(from: instructions)
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
                print("Fetch Instruction in Waiting Payment error: \(error)")
            }
        }
    }
    
    private func getSpecificInstruction(from paymentInstructions: [PaymentInstructions]) -> [SimpleInstruction] {
        var result = [SimpleInstruction]()
        for paymentInstruction in paymentInstructions
        where paymentInstruction.bankCode == self.transaction.bankCode {
            let instruction = SimpleInstruction(instructions: paymentInstruction.instructions,
                                                method: paymentInstruction.paymentMethod)
            result.append(instruction)
        }
        return result
    }
}
