//
//  TextFieldCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 22/10/21.
//

import UIKit

class TextFieldCell: UITableViewCell {
    
    @IBOutlet var textField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setUpView() {
        
    }
}
