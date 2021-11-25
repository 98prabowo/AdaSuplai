//
//  ProfileEditCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 08/11/21.
//

import UIKit
import Combine

class ProfileEditCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    private var profileVM = ProfileViewModel()
    private var isEdit: Bool = false
    private var descString = ""
    let profileEditPublisher = PassthroughSubject<String, Never>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        titleLabel.textColor = .inactive
        descriptionTextField.textColor = .black
        editButton.tintColor = .primaryGreen
        descriptionTextField.isEnabled = false
    }
    
    func configure(titleLabel: String, descriptionLabel: String) {
        self.titleLabel.text = titleLabel
        self.descriptionTextField.text = descriptionLabel
        self.descString = descriptionLabel
        self.editButton.isHidden = false
    }
    
    func configureNoButton(titleLabel: String, descriptionLabel: String) {
        self.titleLabel.text = titleLabel
        self.descriptionTextField.text = descriptionLabel
        self.descString = descriptionLabel
        self.editButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func editButtonClicked(_ sender: UIButton) {
        isEdit = !isEdit
        
        if isEdit {
            descriptionTextField.isEnabled = true
            descriptionTextField.becomeFirstResponder()
            descriptionTextField.borderStyle = .roundedRect
            editButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        } else {
            checkTextfield()
            descriptionTextField.isEnabled = false
            descriptionTextField.borderStyle = .none
            self.resignFirstResponder()
            editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        }
    }
    
    private func checkTextfield() {
        if descriptionTextField.hasText {
            profileVM.updateProfile(data: [getKey(): getValue()]) { result in
                if result {
                    DispatchQueue.main.async {
                        self.profileEditPublisher.send("Success")
                    }
                } else {
                    DispatchQueue.main.async { () -> Void in
                        self.descriptionTextField.text = self.descString
                        self.profileEditPublisher.send(self.profileVM.error)
                    }
                }
            }
        }
    }
    
    private func getValue() -> String {
        return descriptionTextField.text!
    }
    
    private func getKey() -> String {
        switch titleLabel.text {
        case "Nama":
            return "name"
        case "Nama Bisnis":
            return "businessName"
        case "Kategori Bisnis":
            return "businessCategory"
        default:
            return ""
        }
    }
    
}
