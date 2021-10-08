//
//  SubmitButtonCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import UIKit

class SubmitButtonCell: UITableViewCell, Identifiable {
    @IBOutlet weak var submitButton: UIButton!
    
    var submitTitle: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
    }
    
    private func setupButton() {
        self.submitButton.backgroundColor = .primaryGreen
        self.submitButton.tintColor = .systemBackground
        self.submitButton.setTitle(submitTitle ?? "", for: .normal)
        self.submitButton.addBorderAndCornerRadius(withBorderWidth: 0, borderColor: .clear, cornerRadius: 5)
    }
    
    func configure(title: String) {
        self.submitTitle = title
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
    }
}
