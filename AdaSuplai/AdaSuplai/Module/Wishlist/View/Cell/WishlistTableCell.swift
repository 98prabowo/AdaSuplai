//
//  WishlistCell.swift
//  AdaSuplai
//
//  Created by dimas.prabowo on 21/11/21.
//

import UIKit
import Kingfisher

class WishlistTableCell: UITableViewCell {
    private enum Constant {
        static let addToCartButton = "Tambahkan ke keranjang"
        static let trashButton = "trash"
    }
    
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var productVariant: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var trashButton: UIButton!
    @IBOutlet private weak var addToCartButton: UIButton!
    @IBOutlet private weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBackground()
        self.setupButton()
    }
    
    private func setupBackground() {
        self.containerView.addShadow()
        self.containerView.layer.cornerRadius = 10
    }
    
    private func setupButton() {
        self.addToCartButton.setTitle(Constant.addToCartButton,
                                      for: .normal)
        self.addToCartButton.setTitleColor(.primaryGreen, for: .normal)
        self.trashButton.tintColor = .primaryGreen
        self.trashButton.setImage(UIImage(systemName: Constant.trashButton),
                                  for: .normal)
    }
    
    func configure(with product: WishlistProduct) {
        self.productImage.image = UIImage(named: product.image)
        self.productName.text = product.name
        self.productVariant.text = product.variant
        self.price.text = product.price.toIDR
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
    
    @IBAction private func trashButtonTapped(_ sender: UIButton) {
        print("Hapus Item")
    }
    
    @IBAction private func addToCartButton(_ sender: UIButton) {
        print("Tambah ke Keranjang")
    }
}
