//
//  AllCategoryCollectionCell.swift
//  adaSuplaiTrain
//
//  Created by Felicia Devina on 07/10/21.
//

import UIKit
import Kingfisher

class SeeMoreCategoryCollectionCell: UICollectionViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private var categoryImage: UIImageView!
    @IBOutlet private var categoryName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    private func setUpView() {
        self.containerView.backgroundColor = .clear
        self.backgroundColor = .white
        self.addBorderAndCornerRadius(withBorderWidth: 0, borderColor: .clear, cornerRadius: 10)
        containerView.addBorderAndCornerRadius(withBorderWidth: 0, borderColor: .clear, cornerRadius: 10)
        self.categoryImage.backgroundColor = .secondarySystemFill
        self.layer.masksToBounds = true
        self.backgroundColor = .systemBackground
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 1
    }
    
    func configure(with category: Category) {
        self.categoryName.text = category.name
        guard let url = URL(string: RemoteURL.image.rawValue + category.image) else { return }
        setupImage(url: url)
    }
    
    private func setupImage(url: URL) {
        let processor = DownsamplingImageProcessor(size: categoryImage.bounds.size)
        categoryImage.kf.indicatorType = .activity
        categoryImage.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
