//
//  AllCategoryCollectionCell.swift
//  adaSuplaiTrain
//
//  Created by Felicia Devina on 07/10/21.
//

import UIKit

class SeeMoreCategoryCollectionCell: UICollectionViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var categoryName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    private func setUpView() {
        self.containerView.backgroundColor = .clear
        self.backgroundColor = .white
        self.addBorderAndCornerRadius(withBorderWidth: 0, borderColor: .clear, cornerRadius: 10)
        containerView.addBorderAndCornerRadius(withBorderWidth: 0, borderColor: .clear, cornerRadius: 10)
        self.layer.masksToBounds = true
        self.backgroundColor = .systemBackground
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 1
    }
}
