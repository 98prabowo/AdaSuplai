//
//  AllProductCell.swift
//  adaSuplaiTrain2
//
//  Created by Felicia Devina on 05/10/21.
//

import UIKit

class AllProductCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, Identifiable {
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        setUpCollectionView()
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Collection View
    
    func setUpCollectionView(){
        collectionView.register(ProductCollectionView.nib(), forCellWithReuseIdentifier: ProductCollectionView.identifier)
        collectionView.backgroundColor = .systemGray6
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.contentInset = UIEdgeInsets(top: 4, left: 2, bottom: 4, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionView.identifier, for: indexPath) as! ProductCollectionView
        //        cell.configure(with: models[indexPath.row])
        
        cell.layer.cornerRadius = 8
//        cell.layer.borderWidth = 0.0
//        cell.layer.shadowColor = UIColor.systemGray2.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
//        cell.layer.shadowRadius = 3.0
//        cell.layer.shadowOpacity = 0.5
//        cell.layer.masksToBounds = false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numRowItems:CGFloat = 2
        let padding:CGFloat = 8
        let width = (collectionView.bounds.width / numRowItems) - padding
        //        let height = collectionView.bounds.height - (2 * padding)
        return CGSize(width: width, height: 305)
        //        return CGSize(width: 168, height: 280)
    }
    
    // MARK: - END
}
