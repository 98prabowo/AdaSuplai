//
//  WaitingPaymentGuidlineDetailCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 15/11/21.
//

import UIKit

class WaitingPaymentGuidlineDetailCell: UITableViewCell {
    @IBOutlet private weak var guidline: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with guideline: String) {
        self.guidline.attributedText = NSAttributedString(string: guideline)
    }
}
