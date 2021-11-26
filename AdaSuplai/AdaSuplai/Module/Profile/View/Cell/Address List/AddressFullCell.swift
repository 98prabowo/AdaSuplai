//
//  AddressFullCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 25/11/21.
//

import UIKit

class AddressFullCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addressNameLabel: UILabel!
    @IBOutlet weak var nameandPhoneLabel: UILabel!
    @IBOutlet weak var addressDetailLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var provinceandCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupView() {
        containerView.layer.cornerRadius = 8
        containerView.addShadow()
    }
    
    func configure(address: AddressTemp, user: User?) {
        addressNameLabel.text = address.addressName
        nameandPhoneLabel.text = "\(user?.name ?? "nil") | \(user?.phoneNumber ?? "nil")"
        addressDetailLabel.text = address.subdivision
        cityLabel.text = address.city
        provinceandCodeLabel.text = "\(address.province) \(address.postalCode)"
    }
 
}
