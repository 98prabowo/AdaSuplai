//
//  ProfileSettingController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 31/10/21.
//

import UIKit

class ProfileSettingController: BaseUIViewController {
    @IBOutlet var table: UITableView!
    @IBOutlet var logoutButton: UIButton!
    
    private var allTitle = ["Data Diri", "Daftar Alamat", "Metode Pembayaran", "Versi"]
    private var titleSection0 = ["Data Diri", "Keamanan", "Daftar Alamat", "Metode Pembayaran"]
    private var titleSection1 = ["Bahasa", "Syarat dan Ketentuan", "Kebijakan Privasi", "Hak Kekayaan Intelektual", "Ulas Aplikasi ini", "Versi Aplikasi"]
    private var userDefault = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        logoutButton.tintColor = .primaryGreen
        logoutButton.addBorderAndCornerRadius(withBorderWidth: 1, borderColor: .primaryGreen, cornerRadius: 8)
    }
    
    // MARK: - Navigation Bar
    private func setUpNavigationBar() {
        title = "Pengaturan"
        
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .clear
        navigation.navigationBar.isHidden = false
        navigation.navigationItem.hidesBackButton = true
        navigation.navigationBar.tintColor = .primaryGreen
        self.addBackButton()
    }
    
    @IBAction func logOutButtonClicked(_ sender: UIButton) {
        self.userDefault.removeObject(forKey: "userId")
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    private func goToEditProfileController() {
        let nextVC = ProfileEditController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
    
    private func goToAddressListController() {
        let nextVC = ProfileAddressListController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
    
    private func goToPaymentMethodController() {
        let alert = UIAlertController(title: "Akan Datang", message: "Fitur ini sementara tidak tersedia", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
//        let nextVC = ProfileEditController()
//        if let navigationController = self.navigationController {
//            navigationController.pushViewController(nextVC, animated: true)
//        }
    }
    
    private func goToActivityController(text: String) {
        print("Go To My Activity \(text)")
    }
}
// MARK: - Table
extension ProfileSettingController: UITableViewDelegate, UITableViewDataSource {
    private func setUpTable() {
        table.registerNib(forCell: TextCell.self)
        table.registerNib(forCell: HorizontalTextCell.self)
        
        table.backgroundColor = .blueBackground
        table.dataSource = self
        table.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == (table.numberOfRows(inSection: 0) - 1) {
            let cell = tableView.dequeueReusableCell(withCell: HorizontalTextCell.self, for: indexPath)
            cell.configureGrayDesc(title: "Versi Aplikasi", description: "0.0.1")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withCell: TextCell.self, for: indexPath)
            cell.title.text = allTitle[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            self.goToEditProfileController()
        case 1:
            self.goToAddressListController()
        case 2:
            self.goToPaymentMethodController()
        default:
            print("Version")
        }
    }
}
