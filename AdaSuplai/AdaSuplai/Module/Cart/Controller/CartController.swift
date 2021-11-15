//
//  CartController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 19/10/21.
//

import Foundation
import Combine
import UIKit

class CartController: BaseUIViewController {
    private enum Constant {
        static let title = "Keranjang"
        static let totalPrice = "Total Harga"
        static let checkHeader = "Pilih Semua"
        static let deleteText = "Hapus"
        static let buyButtonTittle = "Beli"
    }
    
    @IBOutlet private weak var priceBarView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var totalPriceHeader: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var buyButton: UIButton!
    
    private let viewModel = CartViewModel()
    private var subscriber = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupNavigationBar()
        self.setupPriceBar()
        self.bindToViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let navigation = self.navigationController,
              let tabBarController = self.tabBarController else { return }
        navigation.navigationBar.prefersLargeTitles = true
        tabBarController.tabBar.isHidden = false
        self.viewModel.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.tableView.reloadData()
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.prefersLargeTitles = false
    }
    
    private func setupNavigationBar() {
        self.title = Constant.title
        let refresh = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshTapped(_:)))
        refresh.tintColor = .primaryGreen
        self.navigationItem.rightBarButtonItems = [refresh]
    }
    
    @objc private func refreshTapped(_ sender: UIBarButtonItem) {
        self.viewModel.reloadData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(forCell: CartHeaderCell.self)
        self.tableView.registerNib(forCell: CartSupplierCell.self)
        self.tableView.registerNib(forCell: CartProductCell.self)
    }
    
    private func setupPriceBar() {
        self.priceBarView.addShadow()
        self.price.textColor = .alert
        self.totalPriceHeader.text = Constant.totalPrice
        self.buyButton.layer.cornerRadius = 10
        self.buyButton.backgroundColor = .primaryGreen
        self.buyButton.setTitleColor(.systemBackground, for: .normal)
        self.buyButton.setTitle(Constant.buyButtonTittle, for: .normal)
        self.price.text = self.viewModel.getViewTotalPrice().toIDR
    }
    
    private func bindToViewModel() {
        self.viewModel.cart
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                self.viewModel.getSupplier()
                self.price.text = self.viewModel.getViewTotalPrice().toIDR
                if self.viewModel.isBuyEnable() {
                    self.buyButton.isEnabled = true
                    self.buyButton.backgroundColor = .primaryGreen
                } else {
                    self.buyButton.isEnabled = false
                    self.buyButton.backgroundColor = .gray
                }
            }.store(in: &subscriber)
    }
    
    @IBAction private func buyButtonTapped(_ sender: UIButton) {
        let nextVC = TransactionDetailController(source: .cartPage)
        if let navigation = self.navigationController {
            navigation.pushViewController(nextVC, animated: true)
        }
    }
}

extension CartController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.suppliers.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            let supplierID = self.viewModel.suppliers[section - 1].id
            return self.viewModel.getProductCountPerSection(with: supplierID) + 1
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

// MARK: Setup Table Cell
extension CartController {
    private func getCellForHeader(indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel.isNoProduct() {
            // TODO: Add Empty State Cell
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withCell: CartHeaderCell.self, for: indexPath)
            cell.delegate = self
            cell.configure(checkLabel: Constant.checkHeader,
                           deleteLabel: Constant.deleteText)
            if self.viewModel.isAllProductMarked() {
                cell.checkmarkHeader()
            } else {
                cell.unCheckmarkHeader()
            }
            return cell
        }
    }
    
    private func getCellForBody(indexPath: IndexPath) -> UITableViewCell {
        let supplier = self.viewModel.suppliers[indexPath.section - 1]
        let products = self.viewModel.getProductPerSection(with: supplier.id)
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withCell: CartSupplierCell.self, for: indexPath)
            cell.delegate = self
            cell.configure(with: supplier)
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.size.width, bottom: 0, right: 0)
            if self.viewModel.isAllProductInSectionMarked(supplier.id) {
                cell.checkmarkSupplier()
            } else {
                cell.unCheckmarkSupplier()
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withCell: CartProductCell.self, for: indexPath)
            let product = products[indexPath.row - 1]
            cell.delegate = self
            cell.configure(with: product)
            if product.isMarked {
                cell.checkmarkProduct()
            } else {
                cell.unCheckmarkProduct()
            }
            return cell
        }
    }
}

// MARK: Delegate
extension CartController: CartCellDelegate {
    func cartHeaderAction(actions: CartHeaderCellAction) {
        switch actions {
        case .select(let isMarked):
            if isMarked {
                self.viewModel.checkedAll()
            } else {
                self.viewModel.uncheckedAll()
            }
            self.price.text = self.viewModel.getViewTotalPrice().toIDR
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .delete:
            self.viewModel.removeProduct()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func cartSupplierAction(actions: CartSupplierCellAction) {
        switch actions {
        case .select(let supplier, let isMarked):
            if isMarked {
                self.viewModel.checkedSupplier(supplier.id)
            } else {
                self.viewModel.uncheckedSupplier(supplier.id)
            }
            self.price.text = self.viewModel.getViewTotalPrice().toIDR
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func cartProductActions(actions: CartProductCellAction) {
        switch actions {
        case .stepperChange(let product, let quantity):
            self.viewModel.setSubTotalPrice(from: product, and: quantity)
        case .select(let product, let isMarked):
            if isMarked {
                self.viewModel.checkedProduct(product)
            } else {
                self.viewModel.uncheckedProduct(product)
            }
            self.price.text = self.viewModel.getViewTotalPrice().toIDR
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .addNotes:
            break
        }
    }
}
