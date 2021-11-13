//
//  DeliveryCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 14/10/21.
//

import UIKit

class DeliveryCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var deliveryName: UILabel!
    @IBOutlet private weak var deliveryPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBackground()
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        self.containerView.layer.borderColor = UIColor.primaryGreen.cgColor
//        self.deliveryName.textColor = .primaryGreen
//        self.deliveryPrice.textColor = .black
//    }
    
    private func setupBackground() {
        self.containerView.addBorderAndCornerRadius(withBorderWidth: 0.5, borderColor: .black, cornerRadius: 10)
        self.deliveryName.textColor = .black
        self.deliveryPrice.textColor = .black
    }
    
    // TODO: Add delivery services list
    func configure() {
        self.containerView.layer.borderColor = UIColor.black.cgColor
        self.deliveryName.textColor = .black
        self.deliveryPrice.textColor = .black
    }
    
    func configureSelected() {
        self.containerView.layer.borderColor = UIColor.primaryGreen.cgColor
        self.deliveryName.textColor = .primaryGreen
        self.deliveryPrice.textColor = .black
    }
}
