//
//  ProductReviewCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import UIKit

class ProductReviewCell: UITableViewCell {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var header: UILabel!
    @IBOutlet private weak var star: UIImageView!
    @IBOutlet private weak var rating: UILabel!
    @IBOutlet private weak var ratingQuantity: UILabel!
    @IBOutlet private weak var seeMoreButton: UIButton!
    @IBOutlet private weak var containerView: UIView!
    
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
    
    func configure() {
        
    }
}
