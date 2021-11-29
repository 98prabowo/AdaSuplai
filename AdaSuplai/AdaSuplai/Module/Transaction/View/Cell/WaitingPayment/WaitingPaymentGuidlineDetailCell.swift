//
//  WaitingPaymentGuidlineDetailCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 15/11/21.
//

import UIKit

class WaitingPaymentGuidlineDetailCell: UITableViewCell {
    @IBOutlet private weak var guidline: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with guideline: SimpleInstruction) {
        let instruction = self.getInstruction(from: guideline)
        self.guidline.text = instruction
    }
    
    private func getInstruction(from guideline: SimpleInstruction) -> String {
        var text: String = ""
        for (index, instruction) in guideline.instructions.enumerated() {
            switch index {
            case guideline.instructions.count:
                text += instruction
            default:
                text += instruction + "\n"
            }
        }
        return text
    }
}
