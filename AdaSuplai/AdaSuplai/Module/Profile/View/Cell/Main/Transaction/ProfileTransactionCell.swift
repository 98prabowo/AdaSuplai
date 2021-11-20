//
//  ProfileTransactionCell.swift
//  adaSuplaiTrain2
//
//  Created by Felicia Devina on 06/10/21.
//

import UIKit
import Combine

class ProfileTransactionCell: UITableViewCell {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var containerView: UIView!
    
    private let cellTitle: [String] = ["Penawaran", "", "Menunggu Pembayaran"]
    private let cellImage: [String] = ["penawaran", "", "menunggu_pembayaran"]
    
    let transactionActivityPublisher = PassthroughSubject<String, Never>()
    
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
        tableView.isScrollEnabled = false
        
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
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withCell: TransactionActivityCell.self, for: indexPath)
            cell.configure(title: cellTitle[indexPath.row], image: cellImage[indexPath.row])
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withCell: SeparatorCell.self, for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 1 {
            return 1
        }
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            print(cellTitle[indexPath.row])
            self.transactionActivityPublisher.send(cellTitle[indexPath.row])
        }
    }
}
