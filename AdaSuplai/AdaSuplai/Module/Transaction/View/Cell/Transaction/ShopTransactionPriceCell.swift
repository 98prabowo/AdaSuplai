//
//  ShopTransactionPriceTableViewCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 13/10/21.
//

import UIKit

class ShopTransactionPriceCell: UITableViewCell {
    private enum Constant {
        static let productSubtotal = "Subtotal Produk"
        static let deliverySubtotal = "Subtotal Pengiriman"
        static let delivaryButton = "Pilihan Pengiriman"
    }
    
    @IBOutlet private weak var subTotalProductText: UILabel!
    @IBOutlet private weak var subTotalProductPrice: UILabel!
    @IBOutlet private weak var subTotalDeliveryStack: UIStackView!
    @IBOutlet private weak var subTotalDeliveryText: UILabel!
    @IBOutlet private weak var subTotalDeliveryPrice: UILabel!
    @IBOutlet private weak var deliveryButton: UIView!
    @IBOutlet private weak var busIcon: UIImageView!
    @IBOutlet private weak var pickDeliveryTitle: UILabel!
    @IBOutlet private weak var chevron: UIImageView!
    
    weak var delegate: TransactionCellDelegate?
    private var index: IndexPath?
    private var shipmentPrices = [ShipmentPrice]() {
        didSet {
            if shipmentPrices.isEmpty {
                self.deliveryButton.isUserInteractionEnabled = false
                self.busIcon.tintColor = .gray
                self.chevron.tintColor = .gray
                self.pickDeliveryTitle.textColor = .gray
                self.pickDeliveryTitle.layer.borderColor = UIColor.gray.cgColor
            } else {
                self.deliveryButton.isUserInteractionEnabled = true
                self.busIcon.tintColor = .primaryGreen
                self.chevron.tintColor = .primaryGreen
                self.pickDeliveryTitle.textColor = .primaryGreen
                self.pickDeliveryTitle.layer.borderColor = UIColor.primaryGreen.cgColor
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupText()
        self.setupButton()
    }
    
    private func setupText() {
        self.subTotalProductText.text = Constant.productSubtotal
        self.subTotalDeliveryText.text = Constant.deliverySubtotal
        self.subTotalDeliveryStack.isHidden = true
    }
    
    private func setupButton() {
        self.pickDeliveryTitle.text = Constant.delivaryButton
        self.pickDeliveryTitle.textColor = .gray
        self.busIcon.tintColor = .gray
        self.chevron.tintColor = .gray
        let tapGesture = UITapGestureRecognizer(target: self, action: .some(#selector(deliveryButtonClicked(_:))))
        self.deliveryButton.addGestureRecognizer(tapGesture)
        self.deliveryButton.isUserInteractionEnabled = false
        self.deliveryButton.backgroundColor = .white
        self.deliveryButton.addBorderAndCornerRadius(withBorderWidth: 1,
                                                     borderColor: .primaryGreen,
                                                     cornerRadius: 10)
    }
    
    @objc private func deliveryButtonClicked(_ sender: UITapGestureRecognizer) {
        guard let delegate = self.delegate,
              let index = self.index,
              !self.shipmentPrices.isEmpty else { return }
        delegate.setDeliveryService(shipmentPrices: self.shipmentPrices, index: index)
    }
    
    func configure(with subTotalPrice: Int,
                   index: IndexPath,
                   selected: ShipmentPrice? = nil,
                   and shipmentPrices: [ShipmentPrice]) {
        self.index = index
        self.shipmentPrices = shipmentPrices
        self.subTotalProductPrice.text = subTotalPrice.toIDR
        if let shipmentTitle = selected {
            self.subTotalDeliveryStack.isHidden = false
            self.subTotalDeliveryPrice.text = shipmentTitle.finalPrice.toIDR
            self.pickDeliveryTitle.text = "\(shipmentTitle.logistic.name) \(shipmentTitle.rate.name)"
        }
    }
}
