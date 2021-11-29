//
//  ProductReviewCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import UIKit
import Combine

class ProductReviewCell: UITableViewCell {
    @IBOutlet private weak var header: UILabel!
    @IBOutlet private weak var star: UIImageView!
    @IBOutlet private weak var rating: UILabel!
    @IBOutlet private weak var ratingQuantity: UILabel!
    @IBOutlet private weak var seeMoreButton: UIButton!
    @IBOutlet private weak var containerView: UIView!
    
    var reviewHeaderPublisher = PassthroughSubject<Void, Never>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupStar()
        self.setupButton()
        self.setupBackgroundView()
    }
    
    private func setupBackgroundView() {
        self.containerView.addShadow()
    }
    
    private func setupStar() {
        self.star.tintColor = .star
    }
    
    private func setupButton() {
        self.star.tintColor = .star
        self.seeMoreButton.setTitleColor(.primaryGreen, for: .normal)
    }
    
    func configure(with product: Product) {
        let rating = roundRating(from: product.rating)
        self.rating.text = "\(rating)"
        self.ratingQuantity.text = "dari \(product.reviews.count) Ulasan"
    }
    
    private func roundRating(from data: Double) -> Double {
        return round(10 * data) / 10
    }
    
    @IBAction func seeMoreTapped(_ sender: UIButton) {
        self.reviewHeaderPublisher.send()
    }
}
