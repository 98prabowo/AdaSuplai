//
//  HomeCategoryCollectionCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import UIKit

class HomeCategoryCollectionCell: UICollectionViewCell, Identifiable {
    @IBOutlet private weak var categoryImage: UIImageView!
    @IBOutlet private weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(image: UIImage, categoryName: String) {
        self.categoryImage.image = image
        self.categoryName.text = categoryName
    }
}
