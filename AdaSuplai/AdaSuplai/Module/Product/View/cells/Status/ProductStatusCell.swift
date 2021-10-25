//
//  ProductStatusCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 13/10/21.
//

import UIKit

class ProductStatusCell: UITableViewCell {
    private struct Status {
        let header: String
        let status: String
    }
    
    private var gapIndexItem: Int = 2
    private var gapIndexSize: Int = 2
    private let statuses: [Status] = [
        Status(header: "TERJUAL", status: "156"),
        Status(header: "STOK", status: "500"),
        Status(header: "BERAT", status: "1 Kg"),
        Status(header: "MIN. PESAN", status: "100 ONS")]
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerNib(forCell: StatusProductCollectionCell.self)
    }
}

extension ProductStatusCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.statuses.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: StatusProductCollectionCell.self, for: indexPath)
        switch indexPath.item {
        case 0:
            cell.configureRating(quantity: 102, rating: 5)
        case (self.statuses.count + 1):
            cell.configureSchedule()
        default:
            let status = statuses[indexPath.item - 1]
            cell.configure(title: status.header,
                           status: status.status)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize()
        let height: CGFloat = self.collectionView.bounds.height
        switch indexPath.item {
        case 0:
            size = CGSize(width: 110, height: height)
        case (self.statuses.count + 1):
            size = CGSize(width: 150, height: height)
        default:
            let status = statuses[indexPath.item - 1]
            let headerSize = status.header.size(withAttributes: nil)
            let statusSize = status.status.size(withAttributes: nil)
            let width: CGFloat = max(headerSize.width, statusSize.width)
            size = CGSize(width: width + 60, height: height)
        }
        return size
    }
}
