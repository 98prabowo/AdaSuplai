//
//  ProfileEditController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 07/11/21.
//

import UIKit

class ProfileEditController: BaseUIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    private let titleLabel = ["Nama", "No. Telepon", "Alamat Email", "Nama Bisnis", "Kategori Bisnis"]
    private let descLabel = ["Monica Diana", "082290908923", "mdiana@student.ciputra.ac.id", "Romantica Cafe", "Food & Beverages"]
    private let isHideButton = [false, true, true, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        setUpNavigationBar(isHidden: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar(isHidden: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setUpNavigationBar(isHidden: true)
    }
    
    private func setupView() {
        containerView.addShadow()
        containerView.backgroundColor = .white
        profileImage.layer.cornerRadius = 61
        view.backgroundColor = .blueBackground
        
        let tapGesture = UITapGestureRecognizer(target: self, action: .some(#selector(editImage(_:))))
        tapGesture.delegate = self
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.separatorColor = .black
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.registerNib(forCell: ProfileEditCell.self)
    }
    
    @objc func editImage(_ sender: AnyObject) {
        print("Image Edit")
    }
    
    // MARK: - Navigation Bar
    private func setUpNavigationBar(isHidden: Bool) {
        title = "Monica"
        
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .white
        navigation.navigationBar.isHidden = isHidden
        navigation.navigationItem.hidesBackButton = true
        navigation.navigationBar.tintColor = .primaryGreen
        self.addBackButton()
    }
}

// MARK: - Table
extension ProfileEditController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: ProfileEditCell.self, for: indexPath)
        cell.configure(titleLabel: titleLabel[indexPath.row], descriptionLabel: descLabel[indexPath.row], isHideEdit: isHideButton[indexPath.row])
        return cell
    }
}
