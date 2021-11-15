//
//  PaymentHeaderCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 15/11/21.
//

import UIKit

class PaymentHeaderCell: UITableViewCell {
    @IBOutlet private weak var paymentCategory: UILabel!
    @IBOutlet private weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
    }
    
    private func setupButton() {
        self.addButton.tintColor = .primaryGreen
        self.addButton.isHidden = true
    }
    
    func configure(with title: String) {
        self.paymentCategory.text = title
    }
    
    func configure(with title: String, and buttonTitle: String) {
        self.paymentCategory.text = title
        self.addButton.isHidden = false
        self.addButton.setTitle(buttonTitle, for: .normal)
    }
    
    @IBAction private func addButton(_ sender: UIButton) {
        print("ADD")
    }
}
