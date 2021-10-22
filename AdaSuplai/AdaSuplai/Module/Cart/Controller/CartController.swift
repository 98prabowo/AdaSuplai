//
//  CartController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 19/10/21.
//

import Foundation
import UIKit

class CartController: BaseUIViewController {
    private enum Constant {
        static let title = "Keranjang"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.prefersLargeTitles = false
    }
    
    private func setupNavigationBar() {
        self.title = Constant.title
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .blueBackground
        self.tableView.registerNib(forCell: CartHeaderCell.self)
        self.tableView.registerNib(forCell: CartSupplierCell.self)
        self.tableView.registerNib(forCell: CartProductCell.self)
    }
    
    private func getCellForHeader(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: CartHeaderCell.self, for: indexPath)
        return cell
    }
    
    private func getCellForBody(indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withCell: CartSupplierCell.self, for: indexPath)
            cell.configure()
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withCell: CartProductCell.self, for: indexPath)
            cell.configure()
            if indexPath.row == 2 {
                cell.configureLastItem()
            }
            return cell
        }
    }
}

extension CartController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return self.getCellForHeader(indexPath: indexPath)
        default:
            return self.getCellForBody(indexPath: indexPath)
        }
    }
}
