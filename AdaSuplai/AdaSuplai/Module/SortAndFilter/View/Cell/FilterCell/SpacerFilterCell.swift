//
//  SpacerFilterCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import UIKit

class SpacerFilterCell: UITableViewCell {
    @IBOutlet private weak var lineWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupLine()
    }
    
    private func setupLine() {
        self.lineWidth.constant = 0.6
    }
}
