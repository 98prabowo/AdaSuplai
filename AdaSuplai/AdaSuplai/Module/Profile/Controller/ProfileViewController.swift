//
//  ProfileViewController.swift
//  adaSuplaiTrain2
//
//  Created by Felicia Devina on 05/10/21.
//

import UIKit
import Combine

class ProfileViewController: BaseUIViewController {
    
    @IBOutlet var table: UITableView!
    
    private let viewModel = ProfileViewModel()
    private var subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTable()
        setUpNavigationBar()
    }
    
    // MARK: - Navigation Bar
    private func setUpNavigationBar() {
        title = ""
        view.backgroundColor = .white
        
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .clear
        navigation.navigationBar.isHidden = true
        
        tabBarController?.tabBar.backgroundColor = .white
    }
    
    // MARK: - Navigation
    private func goToAllOrderController() {
        let nextVC = ProfileAllOrderStatusController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
    
    private func goToProfileSettingController() {
        let nextVC = ProfileSettingController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
    
    private func goToEditProfileController() {
        print("Go To Edit Profile")
    }
    
    private func goToActivityController(text: String) {
        print("Go To My Activity \(text)")
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
            cell.profileUserPublisher
                .sink { index in
                    if index == 0 {
                        self.goToEditProfileController()
                    } else {
                        self.goToProfileSettingController()
                    }
                }
                .store(in: &subscribers)
            return cell
            
        case 1 :
            let cell = tableView.dequeueReusableCell(withCell: ProfileTransactionCell.self, for: indexPath)
            cell.transactionActivityPublisher
                .sink { text in
                    print("Go To \(text)")
                }
                .store(in: &subscribers)
            return cell
            
        case 2 :
            let cell = tableView.dequeueReusableCell(withCell: ProfileOrderStatusCell.self, for: indexPath)
            cell.orderStatusPublisher
                .sink { [unowned self] in
                    self.goToAllOrderController()
            }
            .store(in: &subscribers)
            return cell
        case 3 :
            let cell = tableView.dequeueReusableCell(withCell: ProfileInformationsCell.self, for: indexPath)
            cell.myActivityPublisher
                .sink { [unowned self] text in
                    self.goToActivityController(text: text)
            }
            .store(in: &subscribers)
            return cell
            
        default :
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = TransactionDetailController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
}
