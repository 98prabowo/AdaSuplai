//
//  ProductAttributesDeliveryCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import UIKit

class ProductAttributesDeliveryCell: UITableViewCell, Identifiable {
    @IBOutlet private weak var branchs: UIButton!
    @IBOutlet private weak var chevron: UIButton!
    @IBOutlet private weak var deliveredFrom: UILabel!
    @IBOutlet private weak var estimatedTime: UILabel!
    @IBOutlet private weak var minimumWeight: UILabel!
    @IBOutlet private weak var delivaryCost: UILabel!
    @IBOutlet private weak var deliveryTime: UILabel!
    @IBOutlet private var backgroundDays: [UIView]!
    @IBOutlet private var days: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
        self.setupDays()
    }
    
    private func setupButton() {
        self.branchs.setTitleColor(.primaryGreen, for: .normal)
        self.chevron.tintColor = .primaryGreen
    }
    
    private func setupDays() {
        for backgroundDay in backgroundDays {
            backgroundDay.addBorderAndCornerRadius(withBorderWidth: 0.5, borderColor: .label, cornerRadius: 0)
        }
        
        for i in 0..<days.count {
            if i > 1 && i < 5 {
                self.days[i].textColor = .primaryGreen
            }
        }
    }
    
    @IBAction func branchsButtonTapped(_ sender: Any) {
    }
    
    @IBAction func chevronButtonTapped(_ sender: Any) {
    }
}
