//
//  ShopTransactionPriceTableViewCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 13/10/21.
//

import UIKit

class ShopTransactionPriceCell: UITableViewCell {
    
    @IBOutlet var deliveryButton: UIView!
    @IBOutlet var subtotalLabel: UILabel!
    @IBOutlet var deliveryfeeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func setUpView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: .some(#selector(deliveryButtonClicked(_:))))
        tapGesture.delegate = self
        deliveryButton.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func deliveryButtonClicked(_ sender: UIView) {
        print("ViewClick")
    }
}
