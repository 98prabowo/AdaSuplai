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
    
    private var titleSection0 = ["Data Diri", "Keamanan", "Daftar Alamat", "Metode Pembayaran"]
    private var titleSection1 = ["Bahasa", "Syarat dan Ketentuan", "Kebijakan Privasi", "Hak Kekayaan Intelektual", "Ulas Aplikasi ini", "Versi Aplikasi"]
    private var userDefault = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar(isHidden: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setUpNavigationBar(isHidden: true)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        logoutButton.tintColor = .primaryGreen
        logoutButton.addBorderAndCornerRadius(withBorderWidth: 1, borderColor: .primaryGreen, cornerRadius: 8)
    }
    
    // MARK: - Navigation Bar
    private func setUpNavigationBar(isHidden: Bool) {
        title = "Pengaturan"
        
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .clear
        navigation.navigationBar.isHidden = isHidden
        navigation.navigationItem.hidesBackButton = true
        navigation.navigationBar.tintColor = .primaryGreen
        self.addBackButton()
    }
    
    @IBAction func logOutButtonClicked(_ sender: UIButton) {
        print("Logout")
        self.userDefault.set(false, forKey: "isLogin")
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
// MARK: - Table
extension ProfileSettingController: UITableViewDelegate, UITableViewDataSource {
    private func setUpTable() {
        table.registerNib(forCell: TextCell.self)
        
        table.allowsSelection = false
        table.backgroundColor = .blueBackground
        table.dataSource = self
        table.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return titleSection0.count
        case 1 :
            return titleSection1.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            let cell = tableView.dequeueReusableCell(withCell: TextCell.self, for: indexPath)
            cell.title.text = titleSection0[indexPath.row]
            return cell
        case 1 :
            if indexPath.row == (table.numberOfRows(inSection: 1) - 1) {
                let cell = tableView.dequeueReusableCell(withCell: TextCell.self, for: indexPath)
                cell.title.text = "Versi Aplikasi"
                cell.cellButton.imageView?.image = .none
                cell.cellButton.titleLabel?.text = "1.1.1"
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withCell: TextCell.self, for: indexPath)
            cell.title.text = titleSection1[indexPath.row]
            return cell
            
        default :
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}
