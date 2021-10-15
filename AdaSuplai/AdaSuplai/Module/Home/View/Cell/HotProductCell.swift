//
//  HotProductCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import UIKit
import Combine

class HotProductCell: UITableViewCell, Identifiable {
    @IBOutlet private weak var header: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    let productPublisher = PassthroughSubject<Void, Never>()
    
    var productTrends = [DummyProduct]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerNib(forCell: ProductCell.self)
    }
    
    func configure(with products: [DummyProduct], title: String) {
        self.productTrends = products
        self.header.text = title
    }
}

extension HotProductCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productTrends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: ProductCell.self, for: indexPath)
        cell.configure(product: self.productTrends[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.productPublisher.send()
    }
}
