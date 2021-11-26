//
//  ButtonCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 26/11/21.
//

import UIKit

class ButtonCell: UITableViewCell {

    @IBOutlet weak var doneButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupView() {
        doneButton.tintColor = .primaryGreen
    }
    
    func configure(title: String) {
        doneButton.titleLabel?.text = title
    }
    
}
