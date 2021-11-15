//
//  PaymentDetailCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 15/11/21.
//

import UIKit
import Kingfisher

class PaymentDetailCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var paymentImage: UIImageView!
    @IBOutlet private weak var paymentMethod: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBackground()
    }
    
    private func setupBackground() {
        self.paymentImage.backgroundColor = .clear
        self.containerView.addBorderAndCornerRadius(withBorderWidth: 0.5, borderColor: .black, cornerRadius: 5)
    }
    
    func configure(with payment: Payment) {
        self.paymentMethod.text = payment.name
        if let imageURL = URL(string: RemoteURL.image.rawValue + payment.logo) {
            self.setupImage(url: imageURL)
        }
    }
    
    func configureSelected() {
        self.containerView.layer.borderColor = UIColor.primaryGreen.cgColor
    }
    
    private func setupImage(url: URL) {
        let processor = DownsamplingImageProcessor(size: paymentImage.bounds.size)
        paymentImage.kf.indicatorType = .activity
        paymentImage.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
