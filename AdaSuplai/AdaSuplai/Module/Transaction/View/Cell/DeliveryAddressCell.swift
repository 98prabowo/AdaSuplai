//
//  DeliveryAddressCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 12/10/21.
//

import UIKit

class DeliveryAddressCell: UITableViewCell, Identifiable {
    
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var addressDetailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
