//
//  ProductReviewCollectionCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import UIKit
import Kingfisher

class ProductReviewCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var reviewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    private func setupView() {
        self.reviewImage.layer.cornerRadius = 5
    }

    func configure(image: String) {
        guard let imageURL = URL(string: RemoteURL.image.rawValue + image) else { return }
        self.setupImage(url: imageURL)
    }
    
    private func setupImage(url: URL) {
        let processor = DownsamplingImageProcessor(size: reviewImage.frame.size)
        reviewImage.kf.indicatorType = .activity
        reviewImage.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
