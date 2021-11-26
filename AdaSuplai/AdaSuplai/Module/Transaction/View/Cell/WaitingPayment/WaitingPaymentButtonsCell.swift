//
//  WaitingPaymentButtonsCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 16/11/21.
//

import UIKit
import Combine
import SwiftUI

class WaitingPaymentButtonsCell: UITableViewCell {
    @IBOutlet private weak var firstButton: UIButton!
    @IBOutlet private weak var secondButton: UIButton!
    
    let waitingPaymentPublisher = PassthroughSubject<WaitingPaymentButtonsCellAction, Never>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
    }
    
    private func setupButton() {
        self.firstButton.backgroundColor = .primaryGreen
        self.firstButton.setTitleColor(.white, for: .normal)
        self.firstButton.layer.cornerRadius = 5
        self.secondButton.backgroundColor = .white
        self.secondButton.setTitleColor(.primaryGreen, for: .normal)
        self.secondButton.addBorderAndCornerRadius(withBorderWidth: 0.5,
                                                   borderColor: .primaryGreen,
                                                   cornerRadius: 5)
    }
    
    func configure(with firstBtnTitle: String? = nil, and secondBtnTitle: String? = nil) {
        if let firstTitle = firstBtnTitle {
            self.firstButton.setTitle(firstTitle, for: .normal)
        }
        
        if let secondTitle = secondBtnTitle {
            self.secondButton.setTitle(secondTitle, for: .normal)
        }
    }
    
    @IBAction private func firstButtonTapped(_ sender: UIButton) {
        self.waitingPaymentPublisher.send(.firstTapped)
    }
    
    @IBAction private func secondButtonTapped(_ sender: UIButton) {
        self.waitingPaymentPublisher.send(.secondTapped)
    }
}

enum WaitingPaymentButtonsCellAction {
    case firstTapped
    case secondTapped
}
