//
//  WishlistCollectionController.swift
//  AdaSuplai
//
//  Created by dimas.prabowo on 21/11/21.
//

import UIKit

class WishlistCollectionController: BaseUIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let viewModel = WishlistCollectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .blueBackground
        let layout = WaterfallLayout()
        layout.delegate = self
        layout.numberOfColumn = 2
        layout.horizontalContentInset = 10
        layout.verticalContentInset = 10
        self.collectionView.collectionViewLayout = layout
        self.collectionView.registerNib(forCell: WishlistCollectionCell.self)
    }
}

extension WishlistCollectionController: UICollectionViewDelegate, UICollectionViewDataSource, WaterfallLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: WishlistCollectionCell.self, for: indexPath)
        let category = self.viewModel.categories[indexPath.item]
        cell.configure(with: category)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 320
        return height
    }
}
