//
//  FilterCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import UIKit

class FilterCell: UITableViewCell, Identifiable {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterTitle: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: FilterCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: FilterCollectionCell.identifier)
    }
    
    @IBAction func seeMoreButtonTapped(_ sender: Any) {
    }
}

extension FilterCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionCell.identifier, for: indexPath) as? FilterCollectionCell else { return UICollectionViewCell() }
        return cell
    }
}
