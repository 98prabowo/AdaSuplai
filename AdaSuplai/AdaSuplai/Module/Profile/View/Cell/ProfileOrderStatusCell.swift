//
//  StatusPemesananCell.swift
//  adaSuplaiTrain
//
//  Created by Felicia Devina on 06/10/21.
//

import UIKit

class ProfileOrderStatusCell: UITableViewCell, Identifiable {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        setUpView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
        
        self.collectionView.registerNib(forCell: ProfileOrderStatusCollectionCell.self)
    }
    
}

// MARK: - Table
extension ProfileOrderStatusCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileOrderStatusCollectionCell.identifier, for: indexPath) as? ProfileOrderStatusCollectionCell
            cell!.textLabel.text = "Pesanan diambil Kurir"
            cell?.numberLabel.text = "200"
            
            cell?.circleViewWidth.constant = collectionViewSize()
            cell?.circleViewHeight.constant = collectionViewSize()
            cell?.circleView.layer.masksToBounds = true
            cell?.circleView.layer.cornerRadius = collectionViewSize() / 2
            return cell!
            
        case 1 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileOrderStatusCollectionCell.identifier, for: indexPath) as? ProfileOrderStatusCollectionCell
            cell!.textLabel.text = "Pesanan Dikirim"
            cell?.numberLabel.text = "1"
            
            cell?.circleViewWidth.constant = collectionViewSize()
            cell?.circleViewHeight.constant = collectionViewSize()
            cell?.circleView.layer.masksToBounds = true
            cell?.circleView.layer.cornerRadius = collectionViewSize() / 2
            return cell!
            
        case 2 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileOrderStatusCollectionCell.identifier, for: indexPath) as? ProfileOrderStatusCollectionCell
            cell!.textLabel.text = "Pesanan dalam Perjalanan"
            cell?.numberLabel.text = "5"
            
            cell?.circleViewWidth.constant = collectionViewSize()
            cell?.circleViewHeight.constant = collectionViewSize()
            cell?.circleView.layer.masksToBounds = true
            cell?.circleView.layer.cornerRadius = collectionViewSize() / 2
            return cell!
            
        case 3 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileOrderStatusCollectionCell.identifier, for: indexPath) as? ProfileOrderStatusCollectionCell
            cell!.textLabel.text = "Pesanan Selesai"
            cell?.numberLabel.text = "4"
            
            cell?.circleViewWidth.constant = collectionViewSize()
            cell?.circleViewHeight.constant = collectionViewSize()
            cell?.circleView.layer.masksToBounds = true
            cell?.circleView.layer.cornerRadius = collectionViewSize() / 2
            return cell!
            
        default :
            return UICollectionViewCell()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewSize(), height: 145)
    }
    
    func collectionViewSize() -> CGFloat {
        let numRowItems: CGFloat = 4
        let padding: CGFloat = 8
        let spacing: CGFloat = 0
        let width = (collectionView.bounds.width / numRowItems) - padding - spacing
        return width
    }
    
}
