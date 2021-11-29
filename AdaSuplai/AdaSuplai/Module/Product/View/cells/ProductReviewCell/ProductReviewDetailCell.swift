//
//  ProductReviewDetailCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import UIKit

class ProductReviewDetailCell: UITableViewCell {
    private enum Constant {
        static let emptyStar = "star"
        static let fullStar = "star.fill"
        static let halfStar = "star.leadinghalf.filled"
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var userReview: UILabel!
    @IBOutlet private weak var line: UIView!
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet private var stars: [UIImageView]!
    
    private var images = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupStar()
        self.setupCollectionView()
        self.setupBackgroundView()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerNib(forCell: ProductReviewCollectionCell.self)
    }
    
    private func setupStar() {
        for star in self.stars {
            star.image = UIImage(systemName: Constant.emptyStar)
            star.tintColor = .star
        }
    }
    
    private func setupBackgroundView() {
        self.containerView.addShadow()
    }
    
    func configure(with review: Review) {
        self.userName.text = review.name
        self.userReview.text = review.comment
        self.configureStar(rating: review.rating)
        self.images = review.image.components(separatedBy: ",")
    }
    
    func configureReview(with review: Review) {
        self.userName.text = review.name
        self.userReview.text = review.comment
        self.configureStar(rating: review.rating)
        self.images = review.image.components(separatedBy: ",")
        self.topConstraint.constant = 10
        self.bottomConstraint.constant = 20
    }
    
    private func configureStar(rating: Double) {
        let roundedRating = roundRating(from: rating)
        let integerNumber = Int(roundedRating)
        let floatNumber = Int(roundedRating.truncatingRemainder(dividingBy: 1))
        for index in 0..<integerNumber {
            self.stars[index].image = UIImage(systemName: Constant.fullStar)
        }
        
        if floatNumber > 0 {
            self.stars[integerNumber].image = UIImage(systemName: Constant.halfStar)
        }
    }
    
    private func roundRating(from data: Double) -> Double {
        return round(10 * data) / 10
    }
}

extension ProductReviewDetailCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.images.count > 6 {
            return 6
        }
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: ProductReviewCollectionCell.self, for: indexPath)
        cell.configure(image: self.images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space: CGFloat = 60
        let hInset = collectionView.contentInset.left + collectionView.contentInset.right
        let width = (collectionView.bounds.width - hInset - space) / 5
        return CGSize(width: width, height: width)
    }
}
