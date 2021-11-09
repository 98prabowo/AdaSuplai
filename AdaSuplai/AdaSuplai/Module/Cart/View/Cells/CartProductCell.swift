//
//  CartProductCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 21/10/21.
//

import UIKit

class CartProductCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var checkmark: UIImageView!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var productVariant: UILabel!
    @IBOutlet private weak var productPrice: UILabel!
    @IBOutlet private weak var addNoteButton: UIButton!
    @IBOutlet private weak var quantityCounter: AdaSuplaiStepper!
    @IBOutlet private weak var line: UIView!
    @IBOutlet private weak var bottomSpace: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBackground()
        self.setupButton()
    }
    
    private func setupBackground() {
        self.containerView.addShadow()
        self.productImage.layer.cornerRadius = 10
        self.productImage.backgroundColor = .secondarySystemFill
    }
    
    private func setupButton() {
        self.checkmark.tintColor = .primaryGreen
        self.addNoteButton.setTitleColor(.primaryGreen, for: .normal)
    }
    
    func configure() {
        self.productName.text = "Biji Kopi Robusta"
        self.productVariant.text = "Dark Roast"
        let price = 90_000
        self.productPrice.text = price.toIDR
    }
    
    func configureLastItem() {
        self.line.isHidden = true
        self.containerView.roundSpecificCorners([.bottomLeft, .bottomRight], radius: 20)
        self.bottomSpace.constant = 3
    }
    
    @IBAction func addNoteButtonTapped(_ sender: UIButton) {
    }
}
