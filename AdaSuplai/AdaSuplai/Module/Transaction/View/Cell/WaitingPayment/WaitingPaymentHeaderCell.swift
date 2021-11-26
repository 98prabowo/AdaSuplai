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
}
