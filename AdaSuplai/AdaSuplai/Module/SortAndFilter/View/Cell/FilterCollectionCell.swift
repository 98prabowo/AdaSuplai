//
//  FilterCollectionCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import UIKit

class FilterCollectionCell: UICollectionViewCell, Identifiable {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var filterKey: UILabel!
    @IBOutlet weak var ratingStar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupRating()
        self.setupBackgroundView()
    }

    private func setupBackgroundView() {
        self.containerView.addBorderAndCornerRadius(withBorderWidth: 0.5, borderColor: .label, cornerRadius: 5)
    }
    
    private func setupRating() {
        self.ratingStar.tintColor = .star
        self.ratingStar.isHidden = true
    }
    
    func configure(filterKey: String) {
        self.filterKey.text = filterKey
    }
    
    func configureRating(filterKey: String) {
        self.ratingStar.isHidden = false
        self.filterKey.text = filterKey
    }
}
