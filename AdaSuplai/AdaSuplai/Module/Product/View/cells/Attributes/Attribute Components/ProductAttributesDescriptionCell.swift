//
//  ProductAttributesDescriptionCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import UIKit

class ProductAttributesDescriptionCell: UITableViewCell {
    @IBOutlet private weak var productDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with description: String) {
        self.productDescription.text = description
    }
}
