//
//  TextCell.swift
//  adaSuplaiTrain
//
//  Created by Felicia Devina on 08/10/21.
//

import UIKit

class TextCell: UITableViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var cellButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupView() {
        cellButton.tintColor = .inactive
    }
}
