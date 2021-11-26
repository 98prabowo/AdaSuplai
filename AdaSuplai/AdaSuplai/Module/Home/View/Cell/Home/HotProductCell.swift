//
//  HotProductCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import UIKit
import Combine

class HotProductCell: UITableViewCell {
    @IBOutlet private weak var header: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var productPublisher: PassthroughSubject<Product, Never>?
    
    private var productTrends = [Product]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private var suppliers = [Supplier]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollectionView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productPublisher = PassthroughSubject<Product, Never>()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerNib(forCell: ProductCell.self)
    }
    
    func configure(with products: [Product], suppliers: [Supplier], title: String) {
        self.suppliers = suppliers
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
        let product = self.productTrends[indexPath.item]
        cell.representedIdentifier = product.id
        cell.configure(product: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let publisher = self.productPublisher else { return }
        publisher.send(self.productTrends[indexPath.item])
    }
}
