//
//  HotProductCollectionCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import UIKit

class HotProductCollectionCell: UICollectionViewCell, Identifiable {
    @IBOutlet private weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .secondarySystemBackground
        self.contentView.layer.cornerRadius = 5
    }
}
