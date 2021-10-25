//
//  PromoProductCell.swift
//  adaSuplaiTrain2
//
//  Created by Felicia Devina on 05/10/21.
//

import UIKit

class PromoProductCell: UITableViewCell {
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setUpView() {
        self.backgroundColor = .blueBackground
    }
}
// MARK: - Collection View

extension PromoProductCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setUpCollectionView() {
        collectionView.backgroundColor = .blueBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView.registerNib(forCell: ProductCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: ProductCell.self, for: indexPath)
        cell.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numRowItems: CGFloat = 2.5
        let padding: CGFloat = 8
        let width = (collectionView.bounds.width / numRowItems) - padding
        return CGSize(width: width, height: 300)
    }
}

// MARK: - END
