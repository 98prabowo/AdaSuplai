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
    @IBOutlet private weak var etaDays: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBackground()
        self.setupText()
    }
    
    private func setupBackground() {
        self.containerView.addBorderAndCornerRadius(withBorderWidth: 0.5, borderColor: .black, cornerRadius: 10)
        self.deliveryName.textColor = .black
        self.deliveryPrice.textColor = .black
    }
    
    private func setupText() {
        self.containerView.layer.borderColor = UIColor.black.cgColor
        self.deliveryName.textColor = .black
        self.deliveryPrice.textColor = .black
    }
    
    func configure(with shipmentPrice: ShipmentPrice) {
        self.deliveryName.text = "\(shipmentPrice.logistic.name) \(shipmentPrice.rate.name)"
        self.etaDays.text = "\(shipmentPrice.maxDay) days"
        self.deliveryPrice.text = shipmentPrice.finalPrice.toIDR
    }
}
