//
//  UserTableViewCell.swift
//  adaSuplaiTrain2
//
//  Created by Felicia Devina on 05/10/21.
//

import UIKit
import Combine
import Kingfisher

class ProfileUserCell: UITableViewCell {
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var profileName: UILabel!
    @IBOutlet var profileView: UIView!
    @IBOutlet weak var profileShop: UILabel!
    @IBOutlet weak var settingButton: UIButton!
    
    private enum Constant {
        static let editProfile = 0
        static let setting = 1
    }
    
    let profileUserPublisher = PassthroughSubject<Int, Never>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - Setup
    private func setUpView() {
        contentView.backgroundColor = .white
        self.addShadow(color: .black, opacity: 0.2, radius: 1)
        
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 35
        settingButton.tintColor = .primaryGreen
        profileName.textColor = .primaryGreen
        profileShop.textColor = .inactive
        
        let tapGesture = UITapGestureRecognizer(target: self, action: .some(#selector(goToEditProfile(_:))))
        tapGesture.delegate = self
        profileView.addGestureRecognizer(tapGesture)
    }
    
    func configure(user: User?) {
        if user != nil {
            profileName.text = user!.name
            profileShop.text = user!.businessName
            if let user = user {
                guard let url = URL(string: RemoteURL.image.rawValue + user.profilePicture) else { return }
                setupImage(url: url)
            }
        }
    }
    
    @objc func goToEditProfile(_ sender: UIView) {
        profileUserPublisher.send(Constant.editProfile)
    }
    
    @IBAction func settingButtonClicked(_ sender: UIButton) {
        profileUserPublisher.send(1)
    }
    
    private func setupImage(url: URL) {
        let processor = DownsamplingImageProcessor(size: profileImage.bounds.size)
        profileImage.kf.indicatorType = .activity
        profileImage.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
