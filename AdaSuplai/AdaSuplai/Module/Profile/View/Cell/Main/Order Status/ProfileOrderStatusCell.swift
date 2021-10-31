//
//  StatusPemesananCell.swift
//  adaSuplaiTrain
//
//  Created by Felicia Devina on 06/10/21.
//

import UIKit

class ProfileOrderStatusCell: UITableViewCell {
    
    @IBOutlet var mainNav: UINavigationController!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var seeMoreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTableView()
        setUpView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setUpView() {
        
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        
        self.tableView.registerNib(forCell: OrderSmallCell.self)
    }
    
    @IBAction func seeMoreButtonClicked(_ sender: UIButton) {
        let nextNav = ProfileAllOrderStatusController()
        mainNav.pushViewController(nextNav, animated: true)
    }
    
}

// MARK: - Table
extension ProfileOrderStatusCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withCell: OrderSmallCell.self, for: indexPath)
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withCell: OrderSmallCell.self, for: indexPath)
            return cell
        default :
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 203
    }
    
}
