//
//  WishlistCollectionCell.swift
//  AdaSuplai
//
//  Created by dimas.prabowo on 21/11/21.
//

import UIKit

class WishlistCollectionCell: UICollectionViewCell {
    private enum Constant {
        static let addToCartButton = "Keranjang"
    }
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var groupImage: UIImageView!
    @IBOutlet private weak var groupName: UILabel!
    @IBOutlet private weak var productCount: UILabel!
    @IBOutlet private weak var addToCartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
        self.setupBackground()
    }
    
    private func setupBackground() {
        self.containerView.layer.cornerRadius = 10
        self.containerView.backgroundColor = .white
        self.containerView.addShadow()
    }
    
    private func setupButton() {
        self.addToCartButton.tintColor = .primaryGreen
        self.addToCartButton.setTitle(Constant.addToCartButton, for: .normal)
        self.addToCartButton.setTitleColor(.primaryGreen, for: .normal)
        self.addToCartButton.addBorderAndCornerRadius(withBorderWidth: 0.5,
                                                      borderColor: .primaryGreen,
                                                      cornerRadius: 10)
    }
    
    func configure(with category: WishlistCategory) {
        self.groupImage.image = UIImage(named: category.image)
        self.groupName.text = category.name
        self.productCount.text = "\(category.count) produk tersimpan"
    }

    @IBAction private func addToCartTapped(_ sender: UIButton) {
    }
}
