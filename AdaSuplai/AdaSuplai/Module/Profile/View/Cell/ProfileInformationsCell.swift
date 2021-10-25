//
//  InformationsTableViewCell.swift
//  adaSuplaiTrain
//
//  Created by Felicia Devina on 06/10/21.
//

import UIKit

class ProfileInformationsCell: UITableViewCell {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var containerView: UIView!
    
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
        containerView.backgroundColor = .white
        containerView.addBorderAndCornerRadius(withBorderWidth: 0, borderColor: .clear, cornerRadius: 10)
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = .systemBackground
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 1
    }

}

// MARK: - Table
extension ProfileInformationsCell: UITableViewDelegate, UITableViewDataSource {
    private func setUpTable() {
        table.registerNib(forCell: InformationCell.self)
        table.backgroundColor = UIColor.white
        table.dataSource = self
        table.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withCell: InformationCell.self, for: indexPath)
            cell.title.text = "Ulasan Produk"
            cell.desc.text = "Berikan Penilaian dan Ulas Produk"
            return cell
            
        case 1 :
            let cell = tableView.dequeueReusableCell(withCell: InformationCell.self, for: indexPath)
            cell.title.text = "Pusat Bantuan"
            cell.desc.text = "Solusi Permasalahan dari AdaSuplai"
            return cell
            
        default :
            return UITableViewCell()
        }
    }
}
