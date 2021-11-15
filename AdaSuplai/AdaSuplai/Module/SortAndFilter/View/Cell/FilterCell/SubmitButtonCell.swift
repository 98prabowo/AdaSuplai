//
//  SubmitButtonCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import UIKit
import Combine

class SubmitButtonCell: UITableViewCell {
    @IBOutlet private weak var submitButton: UIButton!
    
    var publisher = PassthroughSubject<Void, Never>()
    
    private var submitTitle: String? {
        didSet {
            self.submitButton.setTitle(submitTitle ?? "", for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
    }
    
    private func setupButton() {
        self.submitButton.backgroundColor = .primaryGreen
        self.submitButton.tintColor = .systemBackground
        self.submitButton.addBorderAndCornerRadius(withBorderWidth: 0, borderColor: .clear, cornerRadius: 5)
    }
    
    func configure(title: String) {
        self.submitTitle = title
    }
    
    @IBAction private func submitButtonTapped(_ sender: Any) {
        self.publisher.send()
    }
}
