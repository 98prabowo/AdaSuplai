//
//  CategoryViewController.swift
//  adaSuplaiTrain
//
//  Created by Felicia Devina on 06/10/21.
//

import UIKit

class CategoryController: BaseUIViewController {
    
    @IBOutlet var table: UITableView!
    var categoryTitle: String = "Nama Kategori"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpTable()
    }
    
    private func configure(title: String) {
        self.title = title
    }
    
    // MARK: - Navigation Bar
    private func setUpNavigationBar() {
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .white
        navigation.navigationBar.barTintColor = .white
        navigation.navigationBar.tintColor = .primaryGreen
        self.view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        self.addBackButton()
        self.addSearchButton(tintColor: .primaryGreen)
    }
}

// MARK: - Table
extension CategoryController: UITableViewDelegate, UITableViewDataSource {
    private func setUpTable() {
        table.register(PromoProductCell.nib(), forCellReuseIdentifier: PromoProductCell.identifier)
        table.register(AllProductCell.nib(), forCellReuseIdentifier: AllProductCell.identifier)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .blueBackground
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withCell: PromoProductCell.self, for: indexPath)
            return cell
            
        case 1 :
            let cell = tableView.dequeueReusableCell(withCell: PromoProductCell.self, for: indexPath)
            return cell
            
        case 2 :
            let cell = tableView.dequeueReusableCell(withCell: AllProductCell.self, for: indexPath)
            cell.mainTableView = tableView
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - END
