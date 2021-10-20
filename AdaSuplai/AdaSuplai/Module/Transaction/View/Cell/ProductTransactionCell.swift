//
//  ProductTransactionCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 12/10/21.
//

import UIKit

class ProductTransactionCell: UITableViewCell, Identifiable {
    
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productWeight: UILabel!
    @IBOutlet var productTotal: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
