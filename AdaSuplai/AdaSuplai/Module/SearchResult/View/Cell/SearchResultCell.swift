//
//  SearchResultCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 06/10/21.
//

import UIKit

class SearchResultCell: UICollectionViewCell, Identifiable {
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
    
    var buttonTapped: Bool = false {
        didSet {
            wishlistButton.isSelected = buttonTapped
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBackgroundView()
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
    
    private func setupWishlistButton() {
        
    }
    
    @IBAction private func wishlistButton(_ sender: Any) {
        print("phew")
    }
    
    func configure(product: DummyProduct) {
        self.productName.text = product.productName
        self.rating.text = "\(product.rating)"
        self.soldCount.text = "\(product.productSold) terjual"
        self.address.text = product.location
        self.unitOfPrice.text = product.uomPrice
        self.minimumOrder.text = "Min. Order " + product.minimumOrder
        self.createDiscountView(product.discount, from: product.realPrice)
        self.productPrice.text = "Rp. \(self.createDiscountPrice(product.discount, from: product.realPrice).toIDR)"
        if let image = product.image {
            self.productImage.image = image
        }
    }
    
    func isDiscount() {
        let price = "Rp. 100.000"
        let realPriceLabel = UILabel()
        realPriceLabel.font.withSize(10)
        realPriceLabel.attributedText = price.strikethroughText
        let discount = createDiscountPercentage("10")
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 3
        self.removeAllStackViewElement()
        stackView.addArrangedSubview(realPriceLabel)
        stackView.addArrangedSubview(discount)
        self.priceStack.addArrangedSubview(stackView)
    }
    
    private func createDiscountView(_ percent: Float, from price: Int) {
        let realPriceLabel = self.createPriceLabel(price)
        let discount = self.createDiscountLabel(percent)
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 3
        self.removeAllStackViewElement()
        stackView.addArrangedSubview(realPriceLabel)
        stackView.addArrangedSubview(discount)
        self.priceStack.addArrangedSubview(stackView)
    }
    
    private func createPriceLabel(_ price: Int) -> UILabel {
        let priceString = "Rp. \(price.toIDR)"
        let realPriceLabel = UILabel()
        realPriceLabel.font.withSize(10)
        realPriceLabel.attributedText = priceString.strikethroughText
        realPriceLabel.adjustsFontSizeToFitWidth = true
        realPriceLabel.minimumScaleFactor = 0.5
        return realPriceLabel
    }
    
    private func createDiscountLabel(_ percent: Float) -> UILabel {
        let discountLabel = createDiscountPercentage(percent)
        discountLabel.adjustsFontSizeToFitWidth = true
        discountLabel.minimumScaleFactor = 0.5
        return discountLabel
    }
    
    private func createDiscountPrice(_ percent: Float, from price: Int) -> Int {
        var result: Float = 0
        result = Float(price) - (Float(price) * percent / 100)
        return Int(result)
    }
    
    private func createDiscountPercentage(_ percent: String) -> UILabel {
        let discount = percent + "%"
        let discountLabel = UILabel()
        discountLabel.text = discount
        discountLabel.textColor = .primaryGreen
        discountLabel.font.withSize(12)
        discountLabel.backgroundColor = .discountBackgroundColor
        discountLabel.layer.cornerRadius = 7
        return discountLabel
    }
    
    private func createDiscountPercentage(_ percent: Float) -> UILabel {
        let discount = "\(percent) %"
        let discountLabel = UILabel()
        discountLabel.text = discount
        discountLabel.textColor = .primaryGreen
        discountLabel.font.withSize(12)
        discountLabel.backgroundColor = .discountBackgroundColor
        discountLabel.layer.cornerRadius = 7
        return discountLabel
    }
    
    private func removeAllStackViewElement() {
        let stackViewInSequence = self.priceStack.arrangedSubviews.filter { imageStackView in
            return imageStackView.isKind(of: UIStackView.self)
        }
        for stackView in stackViewInSequence {
            stackView.removeFromSuperview()
        }
    }
}
