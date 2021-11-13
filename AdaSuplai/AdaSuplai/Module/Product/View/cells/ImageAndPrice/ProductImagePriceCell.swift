//
//  ProductImagePriceCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 13/10/21.
//

import UIKit

class ProductImagePriceCell: UITableViewCell {
    private enum Constant {
        static let wishlisted = "heart.fill"
        static let notwishlist = "heart"
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var wishlistButton: UIButton!
    @IBOutlet private weak var star: UIImageView!
    @IBOutlet private weak var rating: UILabel!
    @IBOutlet private weak var separateRating: UILabel!
    @IBOutlet private weak var reviewQuantity: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    private var product: Product?
    private var isWishlist: Bool = false {
        didSet {
            if self.isWishlist {
                self.wishlistButton.setBackgroundImage(UIImage(systemName: Constant.wishlisted), for: .normal)
            } else {
                self.wishlistButton.setBackgroundImage(UIImage(systemName: Constant.notwishlist), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
        self.setupRating()
        self.setupCollectionView()
        self.setupBackgroundView()
    }
    
    private func setupBackgroundView() {
        self.containerView.addShadow()
    }
    
    private func setupButton() {
        self.star.tintColor = .star
        self.wishlistButton.tintColor = .primaryGreen
    }
    
    private func setupRating() {
        self.rating.textColor = .primaryGreen
        self.reviewQuantity.textColor = .primaryGreen
        self.separateRating.textColor = .primaryGreen
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerNib(forCell: ProductImageCollectionCell.self)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        self.collectionView.collectionViewLayout = layout
    }
    
    @IBAction func wishlistButtonTapped(_ sender: UIButton) {
        self.isWishlist = !self.isWishlist
    }
    
    func configure(with product: Product) {
        self.product = product
        self.productName.text = product.name
        self.rating.text = "\(product.rating)"
        self.price.text = product.price.toIDR
        self.reviewQuantity.text = "102 Ulasan"
    }
}

extension ProductImagePriceCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: ProductImageCollectionCell.self, for: indexPath)
        if let product = self.product {
            cell.configure(product: product)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = self.contentView.frame.width
        return CGSize(width: width, height: 278)
    }
}
