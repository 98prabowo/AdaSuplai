//
//  ProductTransactionCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 12/10/21.
//

import UIKit
import Kingfisher

class ProductTransactionCell: UITableViewCell {
    private enum Constant {
        static let idr = "Rp. "
    }
    
    @IBOutlet private var productImage: UIImageView!
    @IBOutlet private var productName: UILabel!
    @IBOutlet private var productPrice: UILabel!
    @IBOutlet private var productWeight: UILabel!
    @IBOutlet private var productTotal: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with product: ProductCart) {
        self.productName.text = product.productName
        self.productPrice.text = Constant.idr + product.productPrice.toIDR
        self.productTotal.text = "x \(product.quantity)"
        self.productWeight.text = "| @ 10 ons"
        self.productImage.layer.cornerRadius = 5
        guard let imageID = product.image,
              let url = URL(string: RemoteURL.image.rawValue + imageID) else { return }
        self.setupImage(url: url)
    }
    
    private func setupImage(url: URL) {
        let processor = DownsamplingImageProcessor(size: productImage.bounds.size)
        productImage.kf.indicatorType = .activity
        productImage.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
