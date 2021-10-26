//
//  MoreCategorySortFilterCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 25/10/21.
//

import UIKit

class MoreCategorySortFilterCell: UITableViewCell {
    @IBOutlet private weak var sortFilterKey: UILabel!
    @IBOutlet private weak var checkmark: UIImageView!
    @IBOutlet private weak var line: UIView!
    @IBOutlet private weak var lineWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    private func setupView() {
        self.checkmark.tintColor = .primaryGreen
        self.lineWidth.constant = 0.6
    }
    
    func configure(key: String) {
        self.sortFilterKey.text = key
    }
}
