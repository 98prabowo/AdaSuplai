//
//  ProductAttributesDetailCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 14/10/21.
//

import UIKit

class ProductAttributesDetailCell: UITableViewCell {
    @IBOutlet private weak var minimumOrder: UILabel!
    @IBOutlet private weak var netWeight: UILabel!
    @IBOutlet private weak var grossWeight: UILabel!
    @IBOutlet private weak var category: UIButton!
    @IBOutlet private weak var productWindow: UIButton!
    @IBOutlet private weak var tradeMark: UILabel!
    @IBOutlet private weak var expiredAge: UILabel!
    @IBOutlet private weak var size: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
        self.setupBackgroundView()
    }
    
    private func setupBackgroundView() {
        self.containerView.addShadow()
    }
    
    private func setupButton() {
        self.category.setTitleColor(.primaryGreen, for: .normal)
        self.productWindow.setTitleColor(.primaryGreen, for: .normal)
    }
    
    func configure(with product: Product) {
        self.minimumOrder.text = "\(product.minOrder)"
        self.netWeight.text = "\(product.neto)"
        self.grossWeight.text = "\(product.bruto)"
        self.size.text = "\(product.dimension)"
    }
}
