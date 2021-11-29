//
//  ProductAttributesHeaderCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import Combine
import UIKit

enum ProductAttribute: String, CaseIterable {
    case description = "Deskripsi Produk"
    case detail = "Detail Produk"
    case delivary = "Pengiriman"
}

class ProductAttributesHeaderCell: UITableViewCell {
    @IBOutlet private weak var segmentedController: AdaSuplaiSegmentedControl!
    @IBOutlet private weak var containerView: UIView!
    
    let attributesPublisher = PassthroughSubject<ProductAttribute, Never>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
        self.setupBackgroundView()
    }
    
    private func setupBackgroundView() {
        self.containerView.addShadow()
    }
    
    private func setupButton() {
        var segmentTitles = [String]()
        for title in ProductAttribute.allCases {
            segmentTitles.append(title.rawValue)
        }
        self.segmentedController.textSize = 16
        self.segmentedController.textColor = .gray
        self.segmentedController.buttonTitles = segmentTitles
    }
    
    @IBAction private func segmentDidChanged(_ sender: AdaSuplaiSegmentedControl) {
        self.attributesPublisher.send(ProductAttribute.allCases[sender.selectedIndex])
    }
}
