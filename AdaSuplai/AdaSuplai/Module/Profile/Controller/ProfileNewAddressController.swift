//
//  ProfileNewAddressController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 26/11/21.
//

import UIKit

class ProfileNewAddressController: BaseUIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setupTable()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
    }
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.registerNib(forCell: NewAddressCell.self)
        tableView.registerNib(forCell: ButtonCell.self)
        tableView.registerNib(forCell: TitleCell.self)
    }
    
    // MARK: - Navigation Bar
    private func setUpNavigationBar() {
        title = "Tambah Alamat"
        
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .white
        navigation.navigationBar.isHidden = false
        navigation.navigationBar.tintColor = .primaryGreen
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        self.addBackButton()
    }
}

// MARK: - Table
extension ProfileNewAddressController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return 1
        case 1:
            return 3
        case 2:
            return 7
        case 3 :
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withCell: NewAddressCell.self, for: indexPath)
            cell.configure(title: "Judul Alamat")
            return cell
        case 1:
            return setupSection1(indexPath: indexPath)
        case 2:
            return setupSection2(indexPath: indexPath)
        case 3:
            let cell = tableView.dequeueReusableCell(withCell: ButtonCell.self, for: indexPath)
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    private func setupSection1(indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withCell: TitleCell.self, for: indexPath)
            cell.configure(title: "Kontak")
            cell.backgroundColor = .clear
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withCell: NewAddressCell.self, for: indexPath)
            cell.configure(title: "Nama")
            return cell
        case 2 :
            let cell = tableView.dequeueReusableCell(withCell: NewAddressCell.self, for: indexPath)
            cell.configureNumber(title: "No. Telepon")
            return cell
        default :
            return UITableViewCell()
        }
    }
    
    private func setupSection2(indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withCell: TitleCell.self, for: indexPath)
            cell.configure(title: "Detail Alamat")
            cell.backgroundColor = .clear
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withCell: NewAddressCell.self, for: indexPath)
            cell.configure(title: "Alamat")
            return cell
        case 2 :
            let cell = tableView.dequeueReusableCell(withCell: NewAddressCell.self, for: indexPath)
            cell.configure(title: "Provinsi")
            return cell
        case 3 :
            let cell = tableView.dequeueReusableCell(withCell: NewAddressCell.self, for: indexPath)
            cell.configure(title: "Kota / Kabupaten")
            return cell
        case 4 :
            let cell = tableView.dequeueReusableCell(withCell: NewAddressCell.self, for: indexPath)
            cell.configure(title: "Kecamatan")
            return cell
        case 5 :
            let cell = tableView.dequeueReusableCell(withCell: NewAddressCell.self, for: indexPath)
            cell.configure(title: "Kelurahan / Desa")
            return cell
        case 6 :
            let cell = tableView.dequeueReusableCell(withCell: NewAddressCell.self, for: indexPath)
            cell.configureNumber(title: "Kode Pos")
            return cell
        default :
            return UITableViewCell()
        }
    }
}
