//
//  FilterCollectionCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import UIKit

class FilterCollectionCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var filterKey: UILabel!
    @IBOutlet weak var ratingStar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupRating()
        self.setupBackgroundView()
    }

    private func setupBackgroundView() {
        self.filterKey.textColor = .label
        self.containerView.backgroundColor = .systemBackground
        self.containerView.addBorderAndCornerRadius(withBorderWidth: 0.5, borderColor: .label, cornerRadius: 5)
    }
    
    private func setupRating() {
        self.ratingStar.tintColor = .star
        self.ratingStar.isHidden = true
    }
    
    func configure(filterKey: String) {
        self.filterKey.text = filterKey
        self.setupBackgroundView()
    }
    
    func configureRating(filterKey: String) {
        self.ratingStar.isHidden = false
        self.filterKey.text = filterKey
    }
    
    func configureDisable(filterKey: String) {
        self.filterKey.text = filterKey
        self.containerView.backgroundColor = .systemGray5
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor.systemGray5.cgColor
    }
    
    func configureSelected(filterKey: String) {
        self.filterKey.text = filterKey
        self.filterKey.textColor = .primaryGreen
        self.containerView.backgroundColor = .discountBackgroundColor
        self.containerView.addBorderAndCornerRadius(withBorderWidth: 0.5, borderColor: .primaryGreen, cornerRadius: 5)
    }
}
