//
//  HotProductCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import UIKit

class HotProductCell: UITableViewCell, Identifiable {
    @IBOutlet private weak var header: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
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
        self.collectionView.registerNib(forCell: SearchResultCell.self)
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
        let cell = collectionView.dequeueReusableCell(withCell: SearchResultCell.self, for: indexPath)
        cell.configure(product: self.productTrends[indexPath.item])
        return cell
    }
}
