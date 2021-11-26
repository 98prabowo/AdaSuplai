//
//  ImageBannerCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 26/11/21.
//

import UIKit

class ImageBannerCell: UITableViewCell {
    @IBOutlet private weak var banner: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    internal func configure(with image: UIImage) {
        self.banner.image = image
    }
}
