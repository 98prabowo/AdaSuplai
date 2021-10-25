//
//  ProductAttributesCollectionCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import UIKit

class ProductAttributesCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var header: UILabel!
    @IBOutlet private weak var line: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupLine()
    }
    
    private func setupLine() {
        self.line.backgroundColor = .primaryGreen
    }

    func configure(title: String) {
        self.header.text = title
        self.header.textColor = .label
        self.line.isHidden = true
    }
    
    func configureSelected(title: String) {
        self.header.textColor = .primaryGreen
        let boldFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        self.header.attributedText = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: boldFont])
        self.line.isHidden = false
    }
}
