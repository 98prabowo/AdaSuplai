//
//  ProfileTransactionCell.swift
//  adaSuplaiTrain2
//
//  Created by Felicia Devina on 06/10/21.
//

import UIKit

class ProfileTransactionCell: UITableViewCell, Identifiable {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        setUpView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setUpView() {
        containerView.backgroundColor = .white
        containerView.addBorderAndCornerRadius(withBorderWidth: 0, borderColor: .clear, cornerRadius: 10)
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = .systemBackground
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 1
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.collectionView.registerNib(forCell: ProfileTransactionCollectionCell.self)
    }
    
}

// MARK: - Table
extension ProfileTransactionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0 :
            let cell = collectionView.dequeueReusableCell(withCell: ProfileTransactionCollectionCell.self, for: indexPath)
            cell.titleLabel.text = "List Penawaran"
            cell.imageHeight.constant = collectionViewSize() - (1/3 * collectionViewSize())
            cell.imageWidth.constant = collectionViewSize()
            return cell
            
        case 2 :
            let cell = collectionView.dequeueReusableCell(withCell: ProfileTransactionCollectionCell.self, for: indexPath)
            cell.titleLabel.text = "Menunggu Pembayaran"
            cell.imageHeight.constant = collectionViewSize() - (1/3 * collectionViewSize())
            cell.imageWidth.constant = collectionViewSize()
            return cell
            
        case 4 :
            let cell = collectionView.dequeueReusableCell(withCell: ProfileTransactionCollectionCell.self, for: indexPath)
            cell.titleLabel.text = "Semua Transaksi"
            cell.imageHeight.constant = collectionViewSize() - (1/3 * collectionViewSize())
            cell.imageWidth.constant = collectionViewSize()
            return cell
            
        default :
            let cell = collectionView.dequeueReusableCell(withCell: ProfileTransactionCollectionCell.self, for: indexPath)
            cell.titleLabel.text = ""
            cell.imageHeight.constant = collectionViewSize() - (1/3 * collectionViewSize())
            cell.imageWidth.constant = collectionViewSize()
            cell.iconImage.backgroundColor = .black
            cell.backgroundColor = .black
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row % 2 == 1 {
            return CGSize(width: 1, height: 95)
        }
        
        return CGSize(width: collectionViewSize(), height: 95)
    }
    
    func collectionViewSize() -> CGFloat {
        let numRowItems: CGFloat = 3
        let padding: CGFloat = 8
        let spacing: CGFloat = 2
        let width = (collectionView.bounds.width / numRowItems) - padding - (numRowItems * spacing)
        return width
    }
}
