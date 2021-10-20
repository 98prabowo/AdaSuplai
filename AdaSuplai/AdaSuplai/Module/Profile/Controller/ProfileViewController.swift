//
//  ProfileViewController.swift
//  adaSuplaiTrain2
//
//  Created by Felicia Devina on 05/10/21.
//

import UIKit

class ProfileViewController: BaseUIViewController {
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTable()
        setUpNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation Bar
    
    private func setUpNavigationBar() {
        title = "Profile"
        
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .blueBackground
        navigation.navigationBar.isHidden = true
        view.backgroundColor = .blueBackground
        
        tabBarController?.tabBar.backgroundColor = .white
        
    }
}

// MARK: - Table
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setUpTable() {
        table.registerNib(forCell: ProfileUserCell.self)
        table.registerNib(forCell: ProfileOrderStatusCell.self)
        table.registerNib(forCell: ProfileTransactionCell.self)
        table.registerNib(forCell: ProfileInformationsCell.self)
        
        table.allowsSelection = false
        table.separatorStyle = .none
        table.backgroundColor = .blueBackground
        table.dataSource = self
        table.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withCell: ProfileUserCell.self, for: indexPath)
            return cell
            
        case 1 :
            let cell = tableView.dequeueReusableCell(withCell: ProfileOrderStatusCell.self, for: indexPath)
            return cell
            
        case 2 :
            let cell = tableView.dequeueReusableCell(withCell: ProfileTransactionCell.self, for: indexPath)
            return cell
            
        case 3 :
            let cell = tableView.dequeueReusableCell(withCell: ProfileInformationsCell.self, for: indexPath)
            return cell
            
        default :
            return UITableViewCell()
        }
    }
}
