//
//  FilterHeaderCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import UIKit

class FilterHeaderCell: UITableViewCell, Identifiable {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
    }
    
    private func setupButton() {
        self.closeButton.tintColor = .label
        self.resetButton.setTitleColor(.aler, for: .normal)
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        print("Close")
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        print("Reset")
    }
}
