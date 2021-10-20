//
//  ProfileOrderStatusCollectionCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 12/10/21.
//

import UIKit

class ProfileOrderStatusCollectionCell: UICollectionViewCell, Identifiable {
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var circleView: UIView!
    @IBOutlet var circleViewHeight: NSLayoutConstraint!
    @IBOutlet var circleViewWidth: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
