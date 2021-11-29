//
//  OrderDetailController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 16/11/21.
//

import UIKit

class OrderDetailController: BaseUIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }

    // MARK: - Navigation Bar
    private func setupNavigationBar() {
        title = " Detail Pesanan"
        view.backgroundColor = .white
        
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .clear
        navigation.navigationBar.isHidden = false
        self.addBackButton()
        navigation.navigationBar.tintColor = .primaryGreen
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .systemGray6
//        tableView.separatorColor = .inactive
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        
        tableView.registerNib(forCell: InvoiceNumberCell.self)
        tableView.registerNib(forCell: ProgressCell.self)
        tableView.registerNib(forCell: SupplierLocationCell.self)
        tableView.registerNib(forCell: HorizontalTextCell.self)
        tableView.registerNib(forCell: ProductOrderDetailCell.self)
    }
}

// MARK: - Table View
extension OrderDetailController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return 1
        case 1 :
            return 4
        case 2 :
            return 7
        default :
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            return getHeaderCell(indexPath: indexPath)
        case 1 :
            return getBodyCell(indexPath: indexPath)
        case 2 :
            return getFooterCell(indexPath: indexPath)
        default :
            return UITableViewCell()
        }
    }
    
    private func getHeaderCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: InvoiceNumberCell.self, for: indexPath)
        return cell
    }
    
    private func getBodyCell(indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withCell: ProgressCell.self, for: indexPath)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width*2)
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withCell: HorizontalTextCell.self, for: indexPath)
            cell.configureHalfBold(title: "ETA", description: "7 Juni 2021")
            return cell
        case 2 :
            let cell = tableView.dequeueReusableCell(withCell: HorizontalTextCell.self, for: indexPath)
            cell.configureHalfBold(title: "Alamat Pengiriman", description: "Cabang Barat")
            return cell
        case 3 :
            let cell = tableView.dequeueReusableCell(withCell: HorizontalTextCell.self, for: indexPath)
            cell.configureHalfBold(title: "Kurir", description: "Indocargo")
            return cell
        default :
            let cell = tableView.dequeueReusableCell(withCell: HorizontalTextCell.self, for: indexPath)
            return cell
        }
    }
    
    private func getFooterCell(indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withCell: SupplierLocationCell.self, for: indexPath)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width*2)
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withCell: ProductOrderDetailCell.self, for: indexPath)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            return cell
        case 2 :
            let cell = tableView.dequeueReusableCell(withCell: ProductOrderDetailCell.self, for: indexPath)
            cell.configure(productImage: "KopiSedikit", productName: "Biji Kopi Arabika", productPrice: "Rp. 90.000", productWeight: "10", productTotal: "1")
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            return cell
        case 3 :
            let cell = tableView.dequeueReusableCell(withCell: HorizontalTextCell.self, for: indexPath)
            let total: Double = (90000 * 12) + (90000 * 2)
            cell.configure(title: "Subtotal Produk", description: "\((total).toIDR)")
            return cell
        case 4 :
            let cell = tableView.dequeueReusableCell(withCell: HorizontalTextCell.self, for: indexPath)
            let total: Double = 25000
            cell.configure(title: "Subtotal Pengiriman", description: "\((total).toIDR)")
            return cell
        case 5 :
            let cell = tableView.dequeueReusableCell(withCell: HorizontalTextCell.self, for: indexPath)
            let total: Double = (90000 * 12) + (90000 * 2) + 25000
            cell.configureBold(title: "Total", description: "\((total).toIDR)")
            return cell
        case 6 :
            let cell = tableView.dequeueReusableCell(withCell: HorizontalTextCell.self, for: indexPath)
            cell.configure(title: "Metode Pembayaran", description: "Mandiri Debit Card")
            return cell
        default :
            return UITableViewCell()
        }
    }
}
