//
//  WaitingPaymentMethodCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 15/11/21.
//

import UIKit
import Combine

class WaitingPaymentMethodCell: UITableViewCell {
    @IBOutlet private weak var transferHeader: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var paymentImage: UIImageView!
    @IBOutlet private weak var codeVA: UILabel!
    @IBOutlet private weak var copyButton: UIButton!
    
    var vaCodePublisher = PassthroughSubject<String, Never>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBackground()
        self.setupButton()
    }
    
    private func setupBackground() {
        self.containerView.layer.cornerRadius = 10
        self.containerView.addShadow()
    }
    
    private func setupButton() {
        self.copyButton.tintColor = .primaryGreen
    }
    
    @IBAction private func copyButtonTapped(_ sender: UIButton) {
        guard let vaCode = codeVA.text else { return }
        self.vaCodePublisher.send(vaCode)
    }
}
