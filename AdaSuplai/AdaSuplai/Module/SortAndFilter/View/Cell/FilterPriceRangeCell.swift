//
//  FilterPriceRangeCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import UIKit

class FilterPriceRangeCell: UITableViewCell, Identifiable {
    private enum Constant {
        static let minPrice = "Min."
        static let maxPrice = "Max."
    }
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var minPrice: UITextField!
    @IBOutlet weak var maxPrice: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTextField()
    }
    
    private func setupTextField() {
        self.minPrice.placeholder = Constant.minPrice
        self.minPrice.keyboardType = .numberPad
        self.minPrice.addBorderAndCornerRadius(withBorderWidth: 0.5, borderColor: .label, cornerRadius: 5)
        self.maxPrice.placeholder = Constant.maxPrice
        self.maxPrice.keyboardType = .numberPad
        self.maxPrice.addBorderAndCornerRadius(withBorderWidth: 0.5, borderColor: .label, cornerRadius: 5)
        self.minPrice.addTarget(self, action: #selector(minPriceDidChanged(_:)), for: .editingChanged)
        self.maxPrice.addTarget(self, action: #selector(maxPriceDidChanged(_:)), for: .editingChanged)
    }
    
    func configure(title: String) {
        self.header.text = title
    }
    
    @objc private func minPriceDidChanged(_ sender: UITextField) {
        self.minPrice.addBorderAndCornerRadius(withBorderWidth: 0.5, borderColor: .primaryGreen, cornerRadius: 5)
        self.minPrice.backgroundColor = .discountBackgroundColor
        self.minPrice.textColor = .primaryGreen
        print(sender.text ?? "")
    }
    
    @objc private func maxPriceDidChanged(_ sender: UITextField) {
        self.maxPrice.addBorderAndCornerRadius(withBorderWidth: 0.5, borderColor: .primaryGreen, cornerRadius: 5)
        self.maxPrice.backgroundColor = .discountBackgroundColor
        self.maxPrice.textColor = .primaryGreen
        print(sender.text ?? "")
    }
}
