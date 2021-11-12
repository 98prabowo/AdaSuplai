//
//  HomeCategoryCollectionCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import UIKit

class HomeCategoryCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var categoryImage: UIImageView!
    @IBOutlet private weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(category: HomeCategory) {
        self.categoryName.text = category.category
        if let image = category.image {
            self.categoryImage.image = image
        }
    }
}
