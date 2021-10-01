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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(HotProductCollectionCell.nib(), forCellWithReuseIdentifier: HotProductCollectionCell.identifier)
    }
    
    func configure(title: String) {
        self.header.text = title
    }
}

extension HotProductCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotProductCollectionCell.identifier, for: indexPath) as? HotProductCollectionCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 90)
    }
}
