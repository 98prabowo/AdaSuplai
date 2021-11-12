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
        static let idr = "Rp. "
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
    private var indexPaths = [IndexPath]()
    
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
        DispatchQueue.main.async {
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
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .blueBackground
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
        self.price.text = Constant.idr +  self.viewModel.getViewTotalPrice().toIDR
    }
    
    private func bindToViewModel() {
        var i = 0
        self.viewModel.cart
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                i += 1
                print(i)
                self.viewModel.getSupplier()
                self.tableView.reloadData()
                self.price.text = Constant.idr +  self.viewModel.getViewTotalPrice().toIDR
            }.store(in: &subscriber)
        
//        self.viewModel.products
//            .receive(on: DispatchQueue.main)
//            .sink { [unowned self] _ in
//                self.viewModel.getSupplier()
//                self.tableView.reloadData()
//            }.store(in: &subscriber)
    }
    
    private func getCellForHeader(indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel.isNoProduct() {
            // TODO: Add Empty State Cell
            return UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withCell: CartHeaderCell.self, for: indexPath)
            cell.delegate = self
            cell.configure(checkLabel: Constant.checkHeader,
                           deleteLabel: Constant.deleteText,
                           indexPath: indexPath)
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
            cell.configure(with: supplier, indexPath: indexPath)
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.frame.width, bottom: 0, right: 0)
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
            cell.configure(with: product,
                           indexPath: indexPath)
            if product.isMarked {
                cell.checkmarkProduct()
            } else {
                cell.unCheckmarkProduct()
            }
            return cell
        }
    }
    
//    private func deleteIndexPath(at indexPath: IndexPath) {
//        for (index, path) in self.indexPaths.enumerated()
//        where path.row == indexPath.row && path.section == indexPath.section {
//            self.indexPaths.remove(at: index)
//        }
//    }
    
    @IBAction func buyButtonTapped(_ sender: UIButton) {
        print("BUY ITEM")
    }
}

extension CartController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        print("Count Supplier: \(self.viewModel.suppliers.count)")
        return self.viewModel.suppliers.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            let supplierID = self.viewModel.suppliers[section - 1].id
            print("Count \(section): \(self.viewModel.getProductCountPerSection(with: supplierID))")
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

extension CartController: CartCellDelegate {
    func cartHeaderAction(actions: CartHeaderCellAction) {
        switch actions {
        case .select(let indexPath, let isMarked):
            if isMarked {
                self.viewModel.checkedAll()
                self.indexPaths.append(indexPath)
            } else {
                self.viewModel.uncheckedAll()
//                self.deleteIndexPath(at: indexPath)
            }
            self.price.text = Constant.idr +  self.viewModel.getViewTotalPrice().toIDR
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .delete:
            self.viewModel.removeProduct()
//            DispatchQueue.main.async {
//                self.tableView.deleteRows(at: self.indexPaths,
//                                          with: .automatic)
//            }
        }
    }
    
    func cartSupplierAction(actions: CartSupplierCellAction) {
        switch actions {
        case .select(let supplier, let indexPath, let isMarked):
            if isMarked {
                self.viewModel.checkedSupplier(supplier.id)
                self.indexPaths.append(indexPath)
            } else {
                self.viewModel.uncheckedSupplier(supplier.id)
//                self.deleteIndexPath(at: indexPath)
            }
            self.price.text = Constant.idr +  self.viewModel.getViewTotalPrice().toIDR
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func cartProductActions(actions: CartProductCellAction) {
        switch actions {
        case .stepperChange(let product):
            self.viewModel.setSubTotalPrice(from: product)
        case .select(let product, let indexPath, let isMarked):
            if isMarked {
                self.viewModel.checkedProduct(product)
                self.indexPaths.append(indexPath)
            } else {
                self.viewModel.uncheckedProduct(product)
//                self.deleteIndexPath(at: indexPath)
            }
            self.price.text = Constant.idr +  self.viewModel.getViewTotalPrice().toIDR
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .addNotes:
            break
        }
    }
}
