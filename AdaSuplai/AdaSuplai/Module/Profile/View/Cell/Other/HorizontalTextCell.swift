//
//  HorizontalTextCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 15/11/21.
//

import UIKit

class HorizontalTextCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureBold(title: String, description: String, isHideSeparator: Bool = true) {
        titleLabel.font = .boldSystemFont(ofSize: 16.0)
        descriptionLabel.font = .boldSystemFont(ofSize: 16.0)
        setupSeparator(isHide: isHideSeparator)
        
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    func configureHalfBold(title: String, description: String, isHideSeparator: Bool = true) {
        titleLabel.textColor = .inactive
        descriptionLabel.font = .boldSystemFont(ofSize: 16.0)
        setupSeparator(isHide: isHideSeparator)
        
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    func configure(title: String, description: String, isHideSeparator: Bool = true) {
        titleLabel.textColor = .inactive
        setupSeparator(isHide: isHideSeparator)
        
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    private func setupSeparator(isHide: Bool) {
        if isHide {
            self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width*2)
        } else {
            self.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
