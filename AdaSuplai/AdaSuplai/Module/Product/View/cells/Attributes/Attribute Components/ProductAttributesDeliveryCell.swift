//
//  ProductAttributesDeliveryCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import UIKit

class ProductAttributesDeliveryCell: UITableViewCell {
    @IBOutlet private weak var branchs: UIButton!
    @IBOutlet private weak var chevron: UIButton!
    @IBOutlet private weak var deliveredFrom: UILabel!
    @IBOutlet private weak var estimatedTime: UILabel!
    @IBOutlet private weak var minimumWeight: UILabel!
    @IBOutlet private weak var delivaryCost: UILabel!
    @IBOutlet private weak var deliveryTime: UILabel!
    @IBOutlet private weak var deliveryDays: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
        self.setupBackgroundView()
    }
    
    private func setupBackgroundView() {
        self.containerView.addShadow()
    }
    
    private func setupButton() {
        self.branchs.setTitleColor(.primaryGreen, for: .normal)
        self.chevron.tintColor = .primaryGreen
    }
    
    func configure(with product: Product) {
        
    }
    
    @IBAction func branchsButtonTapped(_ sender: Any) {
    }
    
    @IBAction func chevronButtonTapped(_ sender: Any) {
    }
}
