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
        self.unitOfPrice.text = "(ons)"
    }
    
    private func setupBackgroundView() {
        self.containerView.backgroundColor = .clear
        self.contentView.addBorderAndCornerRadius(withBorderWidth: 0, borderColor: .clear, cornerRadius: 10)
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = .systemBackground
        
        self.layer.shadowColor = UIColor.systemGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    private func setupWishlistButton() {
        
    }
    
    @IBAction private func wishlistButton(_ sender: Any) {
        print("phew")
    }
    
    func isDiscount() {
        let price = "Rp. 100.000"
        let realPriceLabel = UILabel()
        realPriceLabel.font.withSize(12)
        realPriceLabel.attributedText = price.strikethroughText
        let discount = createDiscountPercentage("10")
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 3
        stackView.addArrangedSubview(realPriceLabel)
        stackView.addArrangedSubview(discount)
        self.priceStack.addArrangedSubview(stackView)
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
}
