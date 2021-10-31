//
//  ProfileTransactionCell.swift
//  adaSuplaiTrain2
//
//  Created by Felicia Devina on 06/10/21.
//

import UIKit

class ProfileTransactionCell: UITableViewCell {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTableView()
        setUpView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setUpView() {
        tableView.backgroundColor = .white
        tableView.addBorderAndCornerRadius(withBorderWidth: 0, borderColor: .clear, cornerRadius: 8)
        tableView.layer.masksToBounds = true
        tableView.backgroundColor = .systemBackground
        tableView.layer.masksToBounds = false
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 0.2
        tableView.layer.shadowOffset = .zero
        tableView.layer.shadowRadius = 1
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        
        self.tableView.registerNib(forCell: TransactionActivityCell.self)
        self.tableView.registerNib(forCell: SeparatorCell.self)
    }
    
}

// MARK: - Table
extension ProfileTransactionCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withCell: TransactionActivityCell.self, for: indexPath)
            cell.titleLabel.text = "Penawaran"
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            return cell
        case 2 :
            let cell = tableView.dequeueReusableCell(withCell: TransactionActivityCell.self, for: indexPath)
            cell.titleLabel.text = "Menunggu Pembayaran"
            cell.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
            return cell
        default :
            let cell = tableView.dequeueReusableCell(withCell: SeparatorCell.self, for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 1 {
            return 1
        }
        return 70
    }
}
