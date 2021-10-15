//
//  ProductImageCollectionCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import UIKit

class ProductImageCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(image: UIImage) {
        self.productImage.image = image
    }
}
