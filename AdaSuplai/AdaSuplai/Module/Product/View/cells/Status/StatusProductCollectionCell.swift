//
//  StatusProductCollectionCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 13/10/21.
//

import UIKit

class StatusProductCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var header: UILabel!
    @IBOutlet private weak var star: UIImageView!
    @IBOutlet private weak var productStatus: UILabel!
    @IBOutlet private weak var scheduleDate: UIStackView!
    @IBOutlet private weak var spacerLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupComponent()
    }
    
    private func setupComponent() {
        self.productStatus.isHidden = false
        self.scheduleDate.isHidden = true
        self.spacerLine.isHidden = false
        self.star.isHidden = true
        self.star.tintColor = .star
    }
    
    func configureRating(quantity: Int, rating: Int) {
        self.header.text = "\(quantity) RATING"
        self.productStatus.text = String(rating)
        self.star.isHidden = false
        self.spacerLine.isHidden = true
    }
    
    func configureSchedule() {
        self.header.text = "JADWAL KIRIM"
        self.productStatus.isHidden = true
        self.scheduleDate.isHidden = false
    }
    
    func configure(title: String, status: String) {
        self.header.text = title
        self.productStatus.text = status
    }
}
