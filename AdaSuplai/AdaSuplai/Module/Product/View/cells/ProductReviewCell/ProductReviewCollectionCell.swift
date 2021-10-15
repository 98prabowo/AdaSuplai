//
//  ProductReviewCollectionCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import UIKit

class ProductReviewCollectionCell: UICollectionViewCell, Identifiable {
    @IBOutlet private weak var reviewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupImage() {
        reviewImage.layer.cornerRadius = 5
    }

    func configure(image: UIImage) {
        self.reviewImage.image = image
    }
}
