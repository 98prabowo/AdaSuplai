//
//  ShopTransactionDetailCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 13/10/21.
//

import UIKit

class ShopTransactionDetailCell: UITableViewCell {
    @IBOutlet private var supplierNameLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var etaLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with supplier: Supplier) {
        self.supplierNameLabel.text = supplier.supplierName
        self.locationLabel.text = supplier.address ?? "-"
    }
    
    func configureETA(with shipmentPrice: ShipmentPrice) {
        guard let createdDate = shipmentPrice.createdDate else { return }
        var dateComponent = DateComponents()
        dateComponent.day = shipmentPrice.maxDay
        if let etaDate = Calendar.current.date(byAdding: dateComponent, to: createdDate) {
            self.etaLabel.text = etaDate.toString(format: .basic)
        }
    }
}
