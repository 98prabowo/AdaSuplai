//
//  SimilarProductCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 13/10/21.
//

import UIKit
import Combine

class SimilarProductCell: UITableViewCell {
    @IBOutlet private weak var header: UILabel!
    @IBOutlet private weak var seeMoreButton: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var products = [Product]()
    var publisher = PassthroughSubject<Product, Never>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
        self.setupCollectionView()
    }
    
    private func setupButton() {
        self.seeMoreButton.setTitleColor(.primaryGreen, for: .normal)
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerNib(forCell: ProductCell.self)
    }
    
    func configure(with products: [Product]) {
        self.products = products
    }
    
    @IBAction private func seeMoreButtonTapped(_ sender: Any) {
    }
}

extension SimilarProductCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = self.products.count
        if count >= 4 {
            count = 4
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: ProductCell.self, for: indexPath)
        let product = self.products[indexPath.item]
        cell.configure(product: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)
        let product = self.products[indexPath.item]
        publisher.send(product)
    }
}
