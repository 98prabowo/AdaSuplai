//
//  ProfileViewController.swift
//  adaSuplaiTrain2
//
//  Created by Felicia Devina on 05/10/21.
//

import UIKit
import Combine

class ProfileViewController: BaseUIViewController {
    
    var userDefault = UserDefaults()
    
    @IBOutlet var table: UITableView!
    
    private let viewModel = ProfileViewModel()
    private var subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTable()
        setUpNavigationBar()
        
        viewModel.profileData.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.subscribers.removeAll(keepingCapacity: true)
                self?.table.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar()
        isLogin()
        viewModel.fetchProfile()
    }
    
    private func isLogin() {
        if userDefault.string(forKey: "userId") == nil {
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            if let myVC = storyboard.instantiateViewController(withIdentifier: "AuthenticationController") as? AuthenticationController {
                self.navigationController?.pushViewController(myVC, animated: true)
            }
        }
    }
    
    // MARK: - Navigation Bar
    private func setUpNavigationBar() {
        title = "Profile"
        view.backgroundColor = .white
        
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .clear
        navigation.navigationBar.isHidden = true
        
        tabBarController?.tabBar.backgroundColor = .white
    }
    
    // MARK: - Navigation
    private func goToAllOrderController() {
        let nextVC = ProfileAllOrderStatusController()
        nextVC.hidesBottomBarWhenPushed = true
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
    
    private func goToProfileSettingController() {
        let nextVC = ProfileSettingController()
        nextVC.hidesBottomBarWhenPushed = true
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
    
    private func goToEditProfileController() {
        let nextVC = ProfileEditController()
        nextVC.hidesBottomBarWhenPushed = true
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
    
    private func goToOrderDetailController(orderId: String) {
        let nextVC = OrderDetailController()
        nextVC.hidesBottomBarWhenPushed = true
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
    
    private func goToActivityController(text: String) {
        let alert = UIAlertController(title: "Akan Datang", message: "Fitur ini sementara tidak tersedia", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
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
            cell.configure(user: (viewModel.profileData.value?.first))
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
                .sink { [unowned self] result in
                    self.orderStatusNavigationCheck(result: result)
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
    
    private func orderStatusNavigationCheck(result: String) {
        switch result {
        case "See More":
            self.goToAllOrderController()
        case "Refresh" :
            self.subscribers.removeAll(keepingCapacity: true)
            self.table.reloadData()
        default :
            self.goToOrderDetailController(orderId: result)
        }
    }
}
