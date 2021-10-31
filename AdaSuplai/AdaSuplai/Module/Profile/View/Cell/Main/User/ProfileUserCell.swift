//
//  UserTableViewCell.swift
//  adaSuplaiTrain2
//
//  Created by Felicia Devina on 05/10/21.
//

import UIKit

class ProfileUserCell: UITableViewCell {
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var profileName: UILabel!
    @IBOutlet var profileView: UIView!
    @IBOutlet weak var profileShop: UILabel!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var mainNavigation: UINavigationController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - Setup
    private func setUpView() {
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 35
        settingButton.tintColor = .primaryGreen
        profileName.textColor = .primaryGreen
        profileShop.textColor = .inactive
        
        let tapGesture = UITapGestureRecognizer(target: self, action: .some(#selector(clickView(_:))))
        tapGesture.delegate = self
        profileView.addGestureRecognizer(tapGesture)
    }
    
    @objc func clickView(_ sender: UIView) {
        print("You clicked on view")
        
    }
    
    @IBAction func settingButtonClicked(_ sender: UIButton) {
        let nextVC = ProfileSettingController()
        mainNavigation.pushViewController(nextVC, animated: true)
    }
}
