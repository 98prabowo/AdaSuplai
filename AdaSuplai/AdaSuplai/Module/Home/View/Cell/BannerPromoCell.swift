//
//  BannerPromoCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import UIKit

class BannerPromoCell: UITableViewCell, Identifiable {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(BannerCollectionCell.nib(), forCellWithReuseIdentifier: BannerCollectionCell.identifier)
    }
}

extension BannerPromoCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionCell.identifier, for: indexPath) as? BannerCollectionCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 125)
    }
}
