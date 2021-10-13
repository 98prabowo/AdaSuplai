//
//  HomeCategoryCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import UIKit

class HomeCategoryCell: UITableViewCell, Identifiable {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var categories = [DummyCategory]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBackgroundView()
        self.setUpCollectionView()
    }
    
    private func setupBackgroundView() {
        self.containerView.roundSpecificCorners([.topRight], radius: 20)
        self.contentView.backgroundColor = .systemGreen
    }
    
    private func setUpCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerNib(forCell: HomeCategoryCollectionCell.self)
    }
    
    func configure(categories: [DummyCategory]) {
        self.categories = categories
    }
}

extension HomeCategoryCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: HomeCategoryCollectionCell.self, for: indexPath)
        cell.configure(category: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(categories[indexPath.item].category)
    }
}
