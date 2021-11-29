//
//  DeliveryAddressCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 12/10/21.
//

import UIKit

protocol TransactionCellDelegate: AnyObject {
    func setDeliveryAddress()
    
    func setDeliveryService(shipmentPrices: [ShipmentPrice], index: IndexPath)
}

class DeliveryAddressCell: UITableViewCell {
    @IBOutlet private weak var header: UILabel!
    @IBOutlet private weak var pickAddressButton: UIView!
    @IBOutlet private weak var address: UILabel!
    @IBOutlet private weak var contact: UILabel!
    @IBOutlet private weak var adressDetail: UILabel!
    @IBOutlet private weak var chevron: UIImageView!
    
    weak var delegate: TransactionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
    }
    
    private func setupButton() {
        let pickAddressGesture = UITapGestureRecognizer(target: self, action: #selector(pickAddressButtonTapped(_:)))
        self.pickAddressButton.addGestureRecognizer(pickAddressGesture)
        self.pickAddressButton.backgroundColor = .clear
        self.address.textColor = .primaryGreen
        self.chevron.tintColor = .black
    }
    
    // TODO: Add user data in here
    func configure() {
    }
    
    @objc private func pickAddressButtonTapped(_ sender: UITapGestureRecognizer) {
        guard let delegate = self.delegate else { return }
        delegate.setDeliveryAddress()
    }
}
