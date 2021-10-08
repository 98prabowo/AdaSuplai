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
    
    var isRating: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollectionView()
        self.setupButton()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: FilterCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: FilterCollectionCell.identifier)
    }
    
    private func setupButton() {
        self.seeMoreButton.isHidden = true
    }
    
    func configure(title: String) {
        self.filterTitle.text = title
    }
    
    func configureSeeMore(title: String) {
        self.filterTitle.text = title
        self.seeMoreButton.isHidden = false
    }
    
    func configureRating(title: String) {
        self.filterTitle.text = title
        self.isRating = true
    }
    
    func configureSeeMoreAndRating(title: String) {
        self.filterTitle.text = title
        self.seeMoreButton.isHidden = false
        self.isRating = true
    }
    
    @IBAction func seeMoreButtonTapped(_ sender: Any) {
    }
}

extension FilterCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionCell.identifier, for: indexPath) as? FilterCollectionCell else { return UICollectionViewCell() }
        if isRating {
            cell.configure(filterKey: "Test filter")
        } else {
            cell.configure(filterKey: "5")
        }
        return cell
    }
}
