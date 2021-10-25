//
//  AllProductCell.swift
//  adaSuplaiTrain2
//
//  Created by Felicia Devina on 05/10/21.
//

import UIKit

class AllProductCell: UITableViewCell {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var mainTableView: UITableView!
    @IBOutlet var collectionViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        setUpCollectionView()
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
// MARK: - Collection View

extension AllProductCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setUpCollectionView() {
        collectionView.backgroundColor = .blueBackground
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        self.collectionView.registerNib(forCell: ProductCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: ProductCell.self, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == indexPath.last {
            self.collectionViewHeight.constant = collectionView.contentSize.height + 20
            print("\(self.collectionViewHeight.constant) == \(collectionView.contentSize.height)")
            mainTableView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numRowItems: CGFloat = 2
        let padding: CGFloat = 16
        let spacing: CGFloat = 4
        let width = (collectionView.bounds.width / numRowItems) - padding - spacing
        return CGSize(width: width, height: 305)
    }
    
}

// MARK: - END
