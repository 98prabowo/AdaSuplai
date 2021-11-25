//
//  TransactionActivityCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 29/10/21.
//

import UIKit

class TransactionActivityCell: UITableViewCell {
    
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var totalProductButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupView() {
        totalProductButton.tintColor = .alert
    }
    
    func configure(title: String, image: String, totalProduct: Int) {
        titleLabel.text = title
        if totalProduct < 100 {
            totalProductButton.titleLabel?.text = "\(totalProduct) Produk"
        } else {
            totalProductButton.titleLabel?.text = "99+ Produk"
        }
        iconImage.image = UIImage(imageLiteralResourceName: image)
    }
    
}
