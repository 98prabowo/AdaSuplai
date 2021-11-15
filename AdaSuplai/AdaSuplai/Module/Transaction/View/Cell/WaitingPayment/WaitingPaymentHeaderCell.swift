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
    @IBOutlet private weak var firstContainer: UIView!
    @IBOutlet private weak var secondContainer: UIView!
    @IBOutlet private weak var totalTitle: UILabel!
    @IBOutlet private weak var totalPrice: UILabel!
    @IBOutlet private weak var expiredDateTitle: UILabel!
    @IBOutlet private weak var expiredDate: UILabel!
    @IBOutlet private weak var expiredTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
