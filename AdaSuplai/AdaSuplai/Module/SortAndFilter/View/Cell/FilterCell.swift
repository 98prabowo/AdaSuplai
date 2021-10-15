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
    
    private var isRating: Bool = false
    private var filterKeys = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollectionView()
        self.setupButton()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerNib(forCell: FilterCollectionCell.self)
    }
    
    private func setupButton() {
        self.seeMoreButton.isHidden = true
    }
    
    func configure(title: String, filterKeys: [String]) {
        self.filterTitle.text = title
        self.filterKeys = filterKeys
    }
    
    func configureSeeMore(title: String, filterKeys: [String]) {
        self.filterTitle.text = title
        self.filterKeys = filterKeys
        self.seeMoreButton.isHidden = false
    }
    
    func configureRating(title: String, filterKeys: [String]) {
        self.filterTitle.text = title
        self.filterKeys = filterKeys
        self.isRating = true
    }
    
    func configureSeeMoreAndRating(title: String, filterKeys: [String]) {
        self.filterTitle.text = title
        self.filterKeys = filterKeys
        self.seeMoreButton.isHidden = false
        self.isRating = true
    }
    
    @IBAction func seeMoreButtonTapped(_ sender: Any) {
    }
}

extension FilterCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filterKeys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: FilterCollectionCell.self, for: indexPath)
        cell.configure(filterKey: self.filterKeys[indexPath.item])
        if isRating {
            cell.configureRating(filterKey: self.filterKeys[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let starWidth: CGFloat = 30
        let stringSize = self.filterKeys[indexPath.item].size(withAttributes: nil)
        var size: CGSize = CGSize(width: stringSize.width + 70, height: stringSize.height + 20)
        if isRating && indexPath.item == 0 {
            size = CGSize(width: stringSize.width + starWidth + 20, height: stringSize.height + 20)
        } else if isRating {
            size = CGSize(width: stringSize.width + starWidth + 50, height: stringSize.height + 20)
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? FilterCollectionCell else { return }
        cell.configureSelected(filterKey: self.filterKeys[indexPath.item])
    }
}
