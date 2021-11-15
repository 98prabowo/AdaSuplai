//
//  WaitingPaymentMethodCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 15/11/21.
//

import UIKit

class WaitingPaymentMethodCell: UITableViewCell {
    @IBOutlet private weak var transferHeader: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var paymentImage: UIImageView!
    @IBOutlet private weak var codeVA: UILabel!
    @IBOutlet private weak var copyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction private func copyButtonTapped(_ sender: UIButton) {
    }
}
