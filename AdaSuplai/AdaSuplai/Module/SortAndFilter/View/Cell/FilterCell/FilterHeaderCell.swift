//
//  FilterHeaderCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import UIKit
import Combine

class FilterHeaderCell: UITableViewCell {
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    
    enum HeaderCellAction {
        case close, reset
    }
    
    var publisher = PassthroughSubject<HeaderCellAction, Never>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
    }
    
    private func setupButton() {
        self.closeButton.tintColor = .label
        self.resetButton.setTitleColor(.alert, for: .normal)
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.publisher.send(.close)
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        self.publisher.send(.reset)
    }
}
