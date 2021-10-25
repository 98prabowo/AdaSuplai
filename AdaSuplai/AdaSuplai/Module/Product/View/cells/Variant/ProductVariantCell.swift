//
//  ProductVariantCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 13/10/21.
//

import UIKit

class ProductVariantCell: UITableViewCell {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var header: UILabel!
    
    private var variants = [String](repeating: "DARK ROAST", count: 5)
    private var isFirst: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerNib(forCell: FilterCollectionCell.self)
    }
    
    private func deselectAllItem() {
        for i in 0..<variants.count {
            let indexPath = IndexPath(item: i, section: 0)
            switch indexPath.item {
            case 4:
                break
            default:
                if let cell = collectionView.cellForItem(at: indexPath) as? FilterCollectionCell {
                    cell.configure(filterKey: "DARK ROAST")
                }
            }
        }
    }
}

extension ProductVariantCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.variants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: FilterCollectionCell.self, for: indexPath)
        switch indexPath.item {
        case 0 where self.isFirst:
            cell.configureSelected(filterKey: "DARK ROAST")
        case 4:
            cell.configureDisable(filterKey: "DARK ROAST")
        default:
            cell.configure(filterKey: "DARK ROAST")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let stringSize = self.variants[indexPath.item].size(withAttributes: nil)
        let size: CGSize = CGSize(width: stringSize.width + 60, height: stringSize.height + 20)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)
        switch indexPath.item {
        case 4:
            break
        default:
            if let cell = collectionView.cellForItem(at: indexPath) as? FilterCollectionCell {
                self.deselectAllItem()
                cell.configureSelected(filterKey: "DARK ROAST")
                self.isFirst = false
            }
        }
    }
}
