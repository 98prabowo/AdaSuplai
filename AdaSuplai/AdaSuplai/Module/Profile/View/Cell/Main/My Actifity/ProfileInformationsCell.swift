//
//  InformationsTableViewCell.swift
//  adaSuplaiTrain
//
//  Created by Felicia Devina on 06/10/21.
//

import UIKit
import Combine

class ProfileInformationsCell: UITableViewCell {
    
    @IBOutlet var table: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    let myActivityPublisher = PassthroughSubject<String, Never>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTable()
        setUpView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setUpView() {
        table.backgroundColor = .white
        table.addBorderAndCornerRadius(withBorderWidth: 0, borderColor: .clear, cornerRadius: 8)
        table.layer.masksToBounds = true
        table.backgroundColor = .systemBackground
        table.layer.masksToBounds = false
        table.layer.shadowColor = UIColor.black.cgColor
        table.layer.shadowOpacity = 0.2
        table.layer.shadowOffset = .zero
        table.layer.shadowRadius = 1
    }
    
}

// MARK: - Table
extension ProfileInformationsCell: UITableViewDelegate, UITableViewDataSource {
    private func setUpTable() {
        table.registerNib(forCell: InformationCell.self)
        table.registerNib(forCell: SeparatorCell.self)
        table.separatorStyle = .none
        table.backgroundColor = UIColor.white
        table.dataSource = self
        table.delegate = self
        
        tableHeight.constant = 2 * 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 1 {
            return 1
        }
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withCell: InformationCell.self, for: indexPath)
            cell.configure(title: "Ulasan Produk", desc: "Berikan Penilaian dan Ulas Produk")
            return cell
            
        case 2 :
            let cell = tableView.dequeueReusableCell(withCell: InformationCell.self, for: indexPath)
            cell.configure(title: "Pusat Bantuan", desc: "Solusi Permasalahan dari AdaSuplai")
            return cell
            
        default :
            let cell = tableView.dequeueReusableCell(withCell: SeparatorCell.self, for: indexPath)
            cell.separatorView.backgroundColor = .lightGray
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            myActivityPublisher.send("Information")
        }
    }
}
