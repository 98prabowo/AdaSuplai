//
//  BannerCollectionCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import UIKit

class BannerCollectionCell: UICollectionViewCell, Identifiable {
    @IBOutlet private weak var banner: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .secondarySystemBackground
        self.contentView.layer.cornerRadius = 10
    }
    
    func configure(banner: UIImage) {
        self.banner.image = banner
    }
}
