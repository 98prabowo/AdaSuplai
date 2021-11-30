//
//  ProductSupplierCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import UIKit
import  Kingfisher

class ProductSupplierCell: UITableViewCell {
    @IBOutlet private weak var supplierImage: UIImageView!
    @IBOutlet private weak var supplierName: UILabel!
    @IBOutlet private weak var star: UIImageView!
    @IBOutlet private weak var rating: UILabel!
    @IBOutlet private weak var timeToProcess: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupImage()
        self.setupBackgroundView()
    }
    
    private func setupImage() {
        self.supplierImage.backgroundColor = .systemGray
        self.supplierImage.layer.cornerRadius = self.supplierImage.frame.width / 2
    }
    
    private func setupBackgroundView() {
        self.containerView.backgroundColor = .blueBackground
        self.containerView.backgroundColor = .systemBackground
        self.containerView.addShadow()
    }
    
    func configure(with supplier: Supplier) {
        self.supplierName.text = supplier.supplierName
        self.rating.text = "4.5"
        self.timeToProcess.text = "6 Jam pesanan diproses"
        if let profile = supplier.profilePicture,
           let imageURL = URL(string: RemoteURL.image.rawValue + profile) {
            self.setupImage(url: imageURL)
        }
    }
    
    private func setupImage(url: URL) {
        let processor = DownsamplingImageProcessor(size: supplierImage.bounds.size)
        supplierImage.kf.indicatorType = .activity
        supplierImage.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
