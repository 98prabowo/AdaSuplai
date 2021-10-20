//
//  InformationCell.swift
//  adaSuplaiTrain
//
//  Created by Felicia Devina on 06/10/21.
//

import UIKit

class InformationCell: UITableViewCell, Identifiable {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var desc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        self.separatorInset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
