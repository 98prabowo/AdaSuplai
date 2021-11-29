//
//  ProductImageCollectionCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import UIKit
import Kingfisher

class ProductImageCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(product: Product) {
        guard let url = URL(string: RemoteURL.image.rawValue + product.image) else { return }
        self.setupImage(url: url)
    }
    
    private func setupImage(url: URL) {
        let processor = DownsamplingImageProcessor(size: productImage.frame.size)
        productImage.kf.indicatorType = .activity
        productImage.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
