//
//  ShopTransactionPriceTableViewCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 13/10/21.
//

import UIKit

class ShopTransactionPriceCell: UITableViewCell {
    private enum Constant {
        static let idr = "Rp. "
        static let productSubtotal = "Subtotal Produk"
        static let deliverySubtotal = "Subtotal Pengiriman"
        static let delivaryButton = "Pilihan Pengiriman"
    }
    
    @IBOutlet private weak var subTotalProductText: UILabel!
    @IBOutlet private weak var subTotalProductPrice: UILabel!
    @IBOutlet private weak var subTotalDeliveryText: UILabel!
    @IBOutlet private weak var subTotalDeliveryPrice: UILabel!
    @IBOutlet private weak var deliveryButton: UIView!
    @IBOutlet private weak var busIcon: UIImageView!
    @IBOutlet private weak var pickDeliveryTitle: UILabel!
    @IBOutlet private weak var chevron: UIImageView!
    
    weak var delegate: TransactionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupText()
        self.setupButton()
    }
    
    private func setupText() {
        self.subTotalProductText.text = Constant.productSubtotal
        self.subTotalDeliveryText.text = Constant.deliverySubtotal
    }
    
    private func setupButton() {
        self.pickDeliveryTitle.text = Constant.delivaryButton
        self.pickDeliveryTitle.textColor = .primaryGreen
        self.busIcon.tintColor = .primaryGreen
        self.chevron.tintColor = .primaryGreen
        let tapGesture = UITapGestureRecognizer(target: self, action: .some(#selector(deliveryButtonClicked(_:))))
        self.deliveryButton.addGestureRecognizer(tapGesture)
        self.deliveryButton.backgroundColor = .white
        self.deliveryButton.addBorderAndCornerRadius(withBorderWidth: 0.5,
                                                     borderColor: .primaryGreen,
                                                     cornerRadius: 10)
    }
    
    func configure(with subTotalPrice: Int) {
        self.subTotalProductPrice.text = Constant.idr + subTotalPrice.toIDR
    }
    
    @objc private func deliveryButtonClicked(_ sender: UITapGestureRecognizer) {
        guard let delegate = delegate else { return }
        delegate.setDeliveryService()
    }
}
