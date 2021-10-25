//
//  ProductImagePriceCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 13/10/21.
//

import UIKit

class ProductImagePriceCell: UITableViewCell {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var wishlistButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
        self.setupCollectionView()
    }
    
    private func setupButton() {
        self.wishlistButton.tintColor = .primaryGreen
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
    }
}

extension ProductImagePriceCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: ProductImageCollectionCell.self, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = self.contentView.frame.width
        return CGSize(width: width, height: 278)
    }
}
