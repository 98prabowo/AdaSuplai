//
//  ProductReviewDetailCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import UIKit

class ProductReviewDetailCell: UITableViewCell {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var userReview: UILabel!
    @IBOutlet private weak var line: UIView!
    @IBOutlet private var stars: [UIImageView]!
    
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
            star.tintColor = .star
        }
    }
    
    private func setupBackgroundView() {
        self.containerView.addShadow()
    }
    
    func configureFirstReview() {
        self.line.isHidden = true
        self.userName.text = "Andika Band"
    }
    
    func configure() {
        self.userName.text = "Andika Band"
    }
}

extension ProductReviewDetailCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: ProductReviewCollectionCell.self, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space: CGFloat = 60
        let hInset = collectionView.contentInset.left + collectionView.contentInset.right
        let width = (collectionView.bounds.width - hInset - space) / 5
        return CGSize(width: width, height: width)
    }
}
