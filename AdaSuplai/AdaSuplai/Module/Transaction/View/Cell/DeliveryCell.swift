//
//  DeliveryCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 14/10/21.
//

import UIKit

class DeliveryCell: UITableViewCell {
    
    @IBOutlet var deliveryName: UILabel!
    @IBOutlet var deliveryPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
