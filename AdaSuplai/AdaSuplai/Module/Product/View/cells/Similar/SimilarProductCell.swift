//
//  SimilarProductCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 13/10/21.
//

import UIKit

class SimilarProductCell: UITableViewCell, Identifiable {
    @IBOutlet private weak var header: UILabel!
    @IBOutlet private weak var seeMoreButton: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
        self.setupCollectionView()
    }
    
    private func setupButton() {
        self.seeMoreButton.setTitleColor(.primaryGreen, for: .normal)
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerNib(forCell: SearchResultCell.self)
    }
    
    @IBAction func seeMoreButtonTapped(_ sender: Any) {
    }
}

extension SimilarProductCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: SearchResultCell.self, for: indexPath)
        return cell
    }
}
