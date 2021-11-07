//
//  ProfileEditCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 08/11/21.
//

import UIKit

class ProfileEditCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        titleLabel.textColor = .inactive
        descriptionLabel.textColor = .black
        editButton.tintColor = .primaryGreen
    }
    
    func configure(titleLabel: String, descriptionLabel: String, isHideEdit: Bool) {
        self.titleLabel.text = titleLabel
        self.descriptionLabel.text = descriptionLabel
        self.editButton.isHidden = isHideEdit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editButtonClicked(_ sender: UIButton) {
        print("Edit")
    }
    
}
