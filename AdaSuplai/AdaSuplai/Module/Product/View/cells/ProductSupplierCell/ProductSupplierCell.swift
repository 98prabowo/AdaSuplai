//
//  ProductSupplierCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import UIKit

class ProductSupplierCell: UITableViewCell, Identifiable {
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
        self.containerView.addShadow(opacity: 0.1, radius: 0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
