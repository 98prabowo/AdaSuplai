//
//  ProfileAddressListController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 25/11/21.
//

import UIKit

class ProfileAddressListController: BaseUIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    private var profileVM = ProfileViewModel()
    private var address: [AddressTemp] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setupTable()
        
        profileVM.profileData.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.address = self?.profileVM.profileData.value?.first?.address ?? []
                self?.setupView()
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        emptyView.backgroundColor = .blueBackground
        emptyView.isHidden = address.count < 1 ? false : true
    }
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .blueBackground
        tableView.separatorStyle = .none
        tableView.registerNib(forCell: AddressFullCell.self)
    }
    
    // MARK: - Navigation Bar
    private func setUpNavigationBar() {
        title = "Daftar Alamat"
        
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .white
        navigation.navigationBar.isHidden = false
        navigation.navigationBar.tintColor = .primaryGreen
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addNavigation(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        addButton.isEnabled = false
        
        self.addBackButton()
    }
    
    @objc private func addNavigation(_ sender: UIBarButtonItem) {
        let nextVC = ProfileNewAddressController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
}

// MARK: - Table
extension ProfileAddressListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return address.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: AddressFullCell.self, for: indexPath)
        cell.configure(address: address[indexPath.row], user: profileVM.profileData.value?.first)
        return cell
    }
}
