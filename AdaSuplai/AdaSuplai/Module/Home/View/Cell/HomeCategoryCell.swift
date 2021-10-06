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
        self.collectionView.register(HomeCategoryCollectionCell.nib(), forCellWithReuseIdentifier: HomeCategoryCollectionCell.identifier)
    }
}

extension HomeCategoryCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCollectionCell.identifier, for: indexPath) as? HomeCategoryCollectionCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 80)
    }
}
