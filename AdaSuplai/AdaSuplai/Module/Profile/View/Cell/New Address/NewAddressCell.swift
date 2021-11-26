//
//  NewAddressCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 26/11/21.
//

import UIKit

class NewAddressCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setupView() {
        
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    func configureNumber(title: String) {
        titleLabel.text = title
        textfield.keyboardType = .numberPad
    }
    
    func configurePicker(title: String) {
        titleLabel.text = title
    }
    
    private func setupPlaceHolder(title: String) {
        
    }
    
}
