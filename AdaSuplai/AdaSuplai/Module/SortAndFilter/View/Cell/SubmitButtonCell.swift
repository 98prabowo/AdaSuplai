//
//  SubmitButtonCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import UIKit

protocol SubmitButtonDelegate: AnyObject {
    func submitTapped()
}

class SubmitButtonCell: UITableViewCell {
    @IBOutlet weak var submitButton: UIButton!
    
    weak var delegate: SubmitButtonDelegate?
    
    var submitTitle: String? {
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
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let delegate = self.delegate else { return }
        delegate.submitTapped()
    }
}
