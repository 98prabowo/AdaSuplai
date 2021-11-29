//
//  TransactionDetailController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 12/10/21.
//

import UIKit
import Combine

class TransactionDetailController: BaseUIViewController {
    private enum Constant {
        static let header = "Pengiriman"
        static let paymentButtonTitle = "Lanjut ke Pembayaran"
    }
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var paymentButton: UIButton!
    @IBOutlet private var productTotalLabel: UILabel!
    @IBOutlet private var deliveryTotalLabel: UILabel!
    @IBOutlet private var totalLabel: UILabel!
    @IBOutlet private var priceBar: UIView!
    
    private let viewModel: TransactionViewModel
    private var subscribers = Set<AnyCancellable>()
    
    init(source: TransactionSource) {
        self.viewModel = TransactionViewModel(from: source)
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBackground()
        self.setupNavigationBar()
        self.setupTableView()
        self.setupButton()
        self.bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
    }
    
    private func setupBackground() {
        self.title = Constant.header
        self.priceBar.addShadow()
        self.view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        guard let tabBarController = self.tabBarController else { return }
        tabBarController.tabBar.isHidden = true
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .white
        navigation.navigationBar.barTintColor = .white
        navigation.navigationBar.tintColor = .primaryGreen
        navigation.setNavigationBarHidden(false, animated: false)
        self.addBackButton()
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsSelection = false
        self.tableView.registerNib(forCell: DeliveryAddressCell.self)
        self.tableView.registerNib(forCell: ShopTransactionDetailCell.self)
        self.tableView.registerNib(forCell: ProductTransactionCell.self)
        self.tableView.registerNib(forCell: ShopTransactionPriceCell.self)
    }
    
    private func setupButton() {
        self.paymentButton.isEnabled = false
        self.paymentButton.tintColor = .white
        self.paymentButton.backgroundColor = .gray
        self.paymentButton.layer.cornerRadius = 10
        self.paymentButton.setTitle(Constant.paymentButtonTitle, for: .normal)
    }
    
    private func bindViewModel() {
        self.viewModel.cart
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                self.viewModel.getSupplier()
                let totalPrice = self.viewModel.getTotalProductPrice()
                self.setTotalPrice(productPrice: totalPrice)
                self.viewModel.addProductToTransaction()
                self.tableView.reloadData()
            }.store(in: &subscribers)
        
        self.viewModel.shipmentPrices
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                self.tableView.reloadData()
            }.store(in: &subscribers)
    }
    
    private func setTotalPrice(productPrice: Int? = nil, deliveryPrice: Int? = nil) {
        if let productPrice = productPrice {
            self.productTotalLabel.text = productPrice.toIDR
        }
        
        if let deliveryPrice = deliveryPrice {
            self.deliveryTotalLabel.text = deliveryPrice.toIDR
        }
        
        if let productPrice = self.productTotalLabel.text,
           let deliveryPrice = self.deliveryTotalLabel.text {
            let totalPrice = productPrice.toIntRemoveIDR + deliveryPrice.toIntRemoveIDR
            self.totalLabel.text = totalPrice.toIDR
        }
    }
    
    @IBAction private func paymentButtonTapped(_ sender: UIButton) {
        guard let navigation = self.navigationController else { return }
        let transaction = self.viewModel.transaction.value
        let nextVC = PaymentController(with: transaction)
        navigation.pushViewController(nextVC, animated: true)
    }
}

extension TransactionDetailController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.suppliers.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            let supplierID = self.viewModel.suppliers[section - 1].id
            return self.viewModel.getProductCountPerSection(with: supplierID) + 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return self.getHeaderCell(for: indexPath)
        default:
            return self.getBodyCell(for: indexPath)
        }
    }
}

// MARK: Setup Table Cell
extension TransactionDetailController {
    private func getHeaderCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withCell: DeliveryAddressCell.self, for: indexPath)
        cell.delegate = self
        cell.configure()
        return cell
    }
    
    private func getBodyCell(for indexPath: IndexPath) -> UITableViewCell {
        let supplier = self.viewModel.suppliers[indexPath.section - 1]
        let products = self.viewModel.getProductPerSection(with: supplier.id)
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withCell: ShopTransactionDetailCell.self, for: indexPath)
            cell.configure(with: supplier)
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.size.width, bottom: 0, right: 0)
            if let suppliers = self.viewModel.transaction.value.suppliers,
               let selectedShipment = suppliers[indexPath.section - 1].shipmentPrice {
                cell.configureETA(with: selectedShipment)
            }
            return cell
        case products.count:
            let cell = tableView.dequeueReusableCell(withCell: ProductTransactionCell.self, for: indexPath)
            let product = products[indexPath.row - 1]
            cell.configure(with: product)
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.size.width, bottom: 0, right: 0)
            return cell
        case products.count + 1:
            let cell = tableView.dequeueReusableCell(withCell: ShopTransactionPriceCell.self, for: indexPath)
            let subtotalPrice = self.viewModel.getTotalProductPricePerSection(with: supplier.id)
            let shipmentPrices = self.viewModel.shipmentPrices.value
            if let suppliers = self.viewModel.transaction.value.suppliers,
               let selectedShipment = suppliers[indexPath.section - 1].shipmentPrice {
                cell.configure(with: subtotalPrice, index: indexPath, selected: selectedShipment, and: shipmentPrices)
            } else {
                cell.configure(with: subtotalPrice, index: indexPath, and: shipmentPrices)
            }
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withCell: ProductTransactionCell.self, for: indexPath)
            let product = products[indexPath.row - 1]
            cell.configure(with: product)
            return cell
        }
    }
}

// MARK: Delegate
extension TransactionDetailController: TransactionCellDelegate {
    func setDeliveryAddress() {
        print("PILIH ALAMAT")
    }
    
    func setDeliveryService(shipmentPrices: [ShipmentPrice], index: IndexPath) {
        let nextVC = DeliveryServiceController(with: self.viewModel.shipmentPrices.value)
        nextVC.deliveryPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shipmentPrice in
                guard let self = self else { return }
                self.viewModel.transaction.value.suppliers?[index.section - 1].shipmentPrice = shipmentPrice
                let deliveryPrice = self.viewModel.getTotalDeliveryPrice()
                self.setTotalPrice(deliveryPrice: deliveryPrice)
                self.paymentButton.isEnabled = true
                self.paymentButton.backgroundColor = .primaryGreen
                self.tableView.reloadData()
            }.store(in: &subscribers)
        
        if let sheet = nextVC.presentationController as? UISheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        self.present(nextVC, animated: true)
    }
}
