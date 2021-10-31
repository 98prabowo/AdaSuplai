//
//  StatusOrderCollectionCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 31/10/21.
//

import UIKit

class StatusOrderCollectionCell: UICollectionViewCell {
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBackground()
    }

    func setupBackground() {
        self.contentView.backgroundColor = .white
        self.statusLabel.font = UIFont.systemFont(ofSize: 17.0)
        self.statusLabel.textColor = .black
        self.selectedView.backgroundColor = .clear
    }
    
    func configure(status: String) {
        self.statusLabel.text = status
        setupBackground()
    }
    
    func configureSelected(status: String) {
//        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
//        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
//        self.statusLabel.attributedText = underlineAttributedString
        self.statusLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.statusLabel.text = status
        self.statusLabel.textColor = .primaryGreen
        
        self.selectedView.backgroundColor = .primaryGreen
    }
    
}
