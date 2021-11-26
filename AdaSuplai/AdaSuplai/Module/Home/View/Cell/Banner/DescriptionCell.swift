//
//  DescriptionCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 26/11/21.
//

import UIKit

class DescriptionCell: UITableViewCell {
    @IBOutlet private weak var bannerDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with description: String) {
        self.bannerDescription.text = description
    }
}
