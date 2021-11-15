//
//  HomeCategoryCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import UIKit
import Combine
import SwiftUI

class HomeCategoryCell: UITableViewCell {
    @IBOutlet private weak var header: UILabel!
    @IBOutlet private weak var seeMore: UIButton!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var categories = [HomeCategory]()
    var categoryPublisher: PassthroughSubject<HomeCategoryAction, Never>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBackgroundView()
        self.setUpCollectionView()
        self.setupButton()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.categoryPublisher = PassthroughSubject<HomeCategoryAction, Never>()
    }
    
    private func setupBackgroundView() {
        self.contentView.backgroundColor = .systemGreen
    }
    
    private func setUpCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerNib(forCell: HomeCategoryCollectionCell.self)
    }
    
    private func setupButton() {
        self.seeMore.setTitleColor(.primaryGreen, for: .normal)
    }
    
    func configure(categories: [HomeCategory]) {
        self.categories = categories
    }
    @IBAction private func seeMoreTapped(_ sender: UIButton) {
        guard let publisher = self.categoryPublisher else { return }
        publisher.send(.seeMore)
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
        guard let publisher = self.categoryPublisher else { return }
        publisher.send(.category(index: indexPath.item))
    }
}

enum HomeCategoryAction {
    case category(index: Int)
    case seeMore
}
