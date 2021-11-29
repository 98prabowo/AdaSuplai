//
//  WaitingPaymentHeaderCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 15/11/21.
//

import UIKit

class WaitingPaymentHeaderCell: UITableViewCell {
    @IBOutlet private weak var paymentMethod: UILabel!
    @IBOutlet private weak var transactionCode: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var totalTitle: UILabel!
    @IBOutlet private weak var totalPrice: UILabel!
    @IBOutlet private weak var expiredDateTitle: UILabel!
    @IBOutlet private weak var expiredDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupText()
        self.setupBackground()
    }
    
    private func setupBackground() {
        self.containerView.layer.cornerRadius = 10
        self.containerView.addShadow()
    }
    
    private func setupText() {
        self.expiredDateTitle.textColor = .alert
        self.expiredDate.textColor = .alert
    }
    
    func configure(with transaction: TransactionResponse) {
        self.transactionCode.text = "Transaksi 210607/7529-10000"
        self.totalPrice.text = transaction.expectedAmount.toIDR
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let expirationDate = dateFormatter.date(from: transaction.expirationDate) {
            self.expiredDate.text = expirationDate.toString(format: .basic)
        }
    }
}
