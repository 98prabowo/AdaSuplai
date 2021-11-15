//
//  WaitingPaymentGuidlineHeaderCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 15/11/21.
//

import UIKit

class WaitingPaymentGuidlineHeaderCell: UITableViewCell {
    @IBOutlet private weak var header: UILabel!
    @IBOutlet private weak var segmentedView: AdaSuplaiSegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with title: String, segmentTitles: [String]) {
        self.header.text = title
        self.segmentedView.buttonTitles = segmentTitles
    }
    
    @IBAction private func segmentDidChanged(_ sender: AdaSuplaiSegmentedControl) {
    }
}
