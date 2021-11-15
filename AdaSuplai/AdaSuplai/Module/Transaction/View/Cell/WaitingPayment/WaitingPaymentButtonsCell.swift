//
//  WaitingPaymentButtonsCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 16/11/21.
//

import UIKit

class WaitingPaymentButtonsCell: UITableViewCell {
    @IBOutlet private weak var seeTransactionButton: UIButton!
    @IBOutlet private weak var shopMoreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction private func seeTransactionTapped(_ sender: UIButton) {
        print("SEE TRANSACTION")
    }
    
    @IBAction private func shopMoreTapped(_ sender: UIButton) {
        print("SHOP MORE")
    }
}
