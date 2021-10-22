//
//  CartSupplierCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 21/10/21.
//

import UIKit

class CartSupplierCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var checkmark: UIImageView!
    @IBOutlet private weak var supplierName: UILabel!
    @IBOutlet private weak var reorderButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBackground()
        self.setupButton()
    }
    
    private func setupBackground() {
        self.containerView.addShadow()
        self.containerView.roundSpecificCorners([.topLeft, .topRight], radius: 20)
    }
    
    private func setupButton() {
        self.checkmark.tintColor = .primaryGreen
        self.reorderButton.tintColor = .primaryGreen
    }
    
    func configure() {
        self.supplierName.text = "MoonBucks"
    }
    
    @IBAction func reorderButtonTapped(_ sender: Any) {
    }
}
