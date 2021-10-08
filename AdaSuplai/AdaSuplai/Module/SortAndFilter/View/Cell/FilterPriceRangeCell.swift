//
//  FilterPriceRangeCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import UIKit

class FilterPriceRangeCell: UITableViewCell, Identifiable {
    @IBOutlet weak var minPrice: UITextField!
    @IBOutlet weak var maxPrice: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTextField()
    }
    
    private func setupTextField() {
        self.minPrice.addTarget(self, action: #selector(minPriceDidChanged(_:)), for: .editingChanged)
        self.maxPrice.addTarget(self, action: #selector(maxPriceDidChanged(_:)), for: .editingChanged)
    }
    
    @objc private func minPriceDidChanged(_ sender: UITextField) {
        print(sender.text ?? "")
    }
    
    @objc private func maxPriceDidChanged(_ sender: UITextField) {
        print(sender.text ?? "")
    }
}
