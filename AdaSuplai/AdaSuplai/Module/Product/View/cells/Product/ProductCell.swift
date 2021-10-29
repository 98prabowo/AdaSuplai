//
//  ProductCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 06/10/21.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var rating: UILabel!
    @IBOutlet private weak var soldCount: UILabel!
    @IBOutlet private weak var address: UILabel!
    @IBOutlet private weak var minimumOrder: UILabel!
    @IBOutlet private weak var productPrice: UILabel!
    @IBOutlet private weak var unitOfPrice: UILabel!
    @IBOutlet private weak var wishlistButton: UIButton!
    @IBOutlet private weak var priceStack: UIStackView!
    @IBOutlet private weak var discountPercentage: UILabel!
    @IBOutlet private weak var realPrice: UILabel!
    @IBOutlet private weak var discountStack: UIStackView!
    
    private var buttonTapped: Bool = false {
        didSet {
            wishlistButton.isSelected = buttonTapped
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupText()
        self.setupBackgroundView()
        self.setupWishlistButton()
    }
    
    private func setupBackgroundView() {
        self.containerView.backgroundColor = .clear
        self.contentView.addBorderAndCornerRadius(withBorderWidth: 0, borderColor: .clear, cornerRadius: 10)
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = .systemBackground
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 1
    }
    
    private func setupText() {
        self.discountStack.isHidden = true
        self.minimumOrder.textColor = .alert
    }
    
    private func setupWishlistButton() {
        self.wishlistButton.isHidden = true
    }
    
    @IBAction private func wishlistButton(_ sender: Any) {
        print("phew")
    }
    
    func configure(product: DummyProduct) {
        self.productName.text = product.productName
        self.rating.text = "\(product.rating)"
        self.soldCount.text = "\(product.productSold) terjual"
        self.address.text = product.location
        self.unitOfPrice.text = "/ " + product.uomPrice
        self.minimumOrder.text = "Min. Order " + product.minimumOrder
        self.productPrice.text = "Rp. \(self.createDiscountPrice(product.discount, from: product.realPrice).toIDR)"
        if let image = product.image {
            self.productImage.image = image
        }
    }
    
    func isDiscount() {
        let price = "Rp. 100.000"
        self.realPrice.attributedText = price.strikethroughText
        self.realPrice.textColor = .alert
        self.discountPercentage.text = " 10% "
        self.discountPercentage.layer.cornerRadius = 2
        self.discountPercentage.textColor = .alert
        self.discountPercentage.backgroundColor = .alertBackground
        self.discountStack.isHidden = false
    }
    
    private func createDiscountPrice(_ percent: Float, from price: Int) -> Int {
        var result: Float = 0
        result = Float(price) - (Float(price) * percent / 100)
        return Int(result)
    }
}
