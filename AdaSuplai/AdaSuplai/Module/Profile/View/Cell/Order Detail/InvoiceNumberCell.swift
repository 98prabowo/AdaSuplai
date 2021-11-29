//
//  InvoiceNumberCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 15/11/21.
//

import UIKit

class InvoiceNumberCell: UITableViewCell {
    @IBOutlet weak var invoiceLabel: UILabel!
    @IBOutlet weak var invoiceButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        invoiceLabel.textColor = .inactive
        invoiceButton.tintColor = .inactive
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
