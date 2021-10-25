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
        
        profileView.backgroundColor = .white
        profileView.addBorderAndCornerRadius(withBorderWidth: 0, borderColor: .clear, cornerRadius: 10)
        profileView.layer.masksToBounds = true
        profileView.backgroundColor = .systemBackground
        profileView.layer.masksToBounds = false
        profileView.layer.shadowColor = UIColor.black.cgColor
        profileView.layer.shadowOpacity = 0.2
        profileView.layer.shadowOffset = .zero
        profileView.layer.shadowRadius = 1
        
        let tapGesture = UITapGestureRecognizer(target: self, action: .some(#selector(clickView(_:))))
        tapGesture.delegate = self
        profileView.addGestureRecognizer(tapGesture)
    }
    
    @objc func clickView(_ sender: UIView) {
        print("You clicked on view")
        
    }
}
