//
//  ProductAttributesHeaderCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import Combine
import UIKit

enum ProductAttribute: String, CaseIterable {
    case description = "Deskripsi Produk"
    case detail = "Detail Produk"
    case delivary = "Pengiriman"
}

class ProductAttributesHeaderCell: UITableViewCell, Identifiable {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var isFirst: Bool = true
    private let attributesPublisher = PassthroughSubject<ProductAttribute, Never>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerNib(forCell: ProductAttributesCollectionCell.self)
        let indexPath = IndexPath(item: 0, section: 0)
        self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
    }
    
    private func deselectAllItem() {
        for i in 0..<ProductAttribute.allCases.count {
            let indexPath = IndexPath(item: i, section: 0)
            let title = ProductAttribute.allCases[indexPath.item].rawValue
            if let cell = collectionView.cellForItem(at: indexPath) as? ProductAttributesCollectionCell {
                cell.configure(title: title)
            }
        }
    }
}

extension ProductAttributesHeaderCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductAttribute.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: ProductAttributesCollectionCell.self, for: indexPath)
        let title = ProductAttribute.allCases[indexPath.item].rawValue
        switch indexPath.item {
        case 0 where self.isFirst:
            cell.configureSelected(title: title)
        default:
            cell.configure(title: title)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let stringSize = ProductAttribute.allCases[indexPath.item].rawValue.size(withAttributes: nil)
        let height: CGFloat = collectionView.bounds.height
        return CGSize(width: stringSize.width + 50, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)
        let title = ProductAttribute.allCases[indexPath.item].rawValue
        if let cell = collectionView.cellForItem(at: indexPath) as? ProductAttributesCollectionCell {
            self.deselectAllItem()
            cell.configureSelected(title: title)
            self.isFirst = false
            self.attributesPublisher.send(ProductAttribute.allCases[indexPath.item])
        }
    }
}
