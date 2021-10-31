//
//  OrderSmallCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 29/10/21.
//

import UIKit

class OrderSmallCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var shopCity: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var otherProductCount: UILabel!
    @IBOutlet weak var etaLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupView() {
        containerView.backgroundColor = .white
        containerView.addBorderAndCornerRadius(withBorderWidth: 0, borderColor: .clear, cornerRadius: 10)
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = .systemBackground
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 1
        
        productImage.roundSpecificCorners(.allCorners, radius: 8)
    }
    
}
