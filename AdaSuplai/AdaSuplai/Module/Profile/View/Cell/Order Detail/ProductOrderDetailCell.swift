//
//  ProductOrderDetailCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 29/11/21.
//

import UIKit

class ProductOrderDetailCell: UITableViewCell {
    
    @IBOutlet private var productImage: UIImageView!
    @IBOutlet private var productName: UILabel!
    @IBOutlet private var productPrice: UILabel!
    @IBOutlet private var productWeight: UILabel!
    @IBOutlet private var productTotal: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(productImage: String, productName: String, productPrice: String, productWeight: String, productTotal: String) {
        self.productName.text = productName
        self.productPrice.text = productPrice
        self.productTotal.text = "x \(productTotal)"
        self.productWeight.text = "| @ 10 ons"
        self.productImage.layer.cornerRadius = 5
        self.productImage.image = UIImage(imageLiteralResourceName: productImage)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
