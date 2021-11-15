//
//  QuantityCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 15/11/21.
//

import UIKit

class QuantityCell: UITableViewCell {

    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var quantityStepper: AdaSuplaiStepper!
    
    weak var delegate: TransactionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .white
        noteButton.tintColor = .primaryGreen
    }
    
    func configure() {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
