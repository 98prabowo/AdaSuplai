//
//  PaymentController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 15/11/21.
//

import UIKit
import Combine

class PaymentController: BaseUIViewController {
    private enum Constant {
        static let header = "Pembayaran"
        static let payButton = "Bayar"
        static let totalHeader = "Total"
    }

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var priceBar: UIView!
    @IBOutlet private weak var totalTitle: UILabel!
    @IBOutlet private weak var totalPrice: UILabel!
    @IBOutlet private weak var buyButton: UIButton!
    
    private let viewModel: PaymentViewModel
    private var subscribers = Set<AnyCancellable>()
    
    init(with transaction: Transaction) {
        self.viewModel = PaymentViewModel(with: transaction)
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var selectedIndex: IndexPath? {
        didSet {
            if selectedIndex != nil {
                self.buyButton.isEnabled = true
                self.buyButton.backgroundColor = .primaryGreen
            } else {
                self.buyButton.isEnabled = false
                self.buyButton.backgroundColor = .gray
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupPriceBar()
        self.setupTableView()
        self.bindViewModel()
    }
    
    private func setupNavigationBar() {
        self.addBackButton()
        self.title = Constant.header
    }
    
    private func setupPriceBar() {
        self.priceBar.addShadow()
        self.totalTitle.text = Constant.totalHeader
        self.buyButton.setTitle(Constant.payButton, for: .normal)
        self.buyButton.setTitleColor(.white, for: .normal)
        self.buyButton.backgroundColor = .primaryGreen
        self.buyButton.layer.cornerRadius = 5
        self.totalPrice.text = self.viewModel.getTotalPrice().toIDR
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .blueBackground
        self.tableView.registerNib(forCell: PaymentHeaderCell.self)
        self.tableView.registerNib(forCell: PaymentDetailCell.self)
    }
    
    private func bindViewModel() {
        self.viewModel.paymentMethods
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                self.viewModel.getPaymentCategories()
                self.tableView.reloadData()
                if selectedIndex == nil {
                    self.buyButton.isEnabled = false
                    self.buyButton.backgroundColor = .gray
                }
            }.store(in: &subscribers)
    }
    
    @IBAction private func buyButton(_ sender: UIButton) {
        guard let navigation = self.navigationController,
              let index = self.selectedIndex else { return }
        let payment = self.viewModel.paymentMethods.value[index.row - 1]
        self.viewModel.transaction.payment = payment
        // TODO: Push to nextVC and post data first
//        let nextVC = WaitingPaymentController(payment: payment)
//        navigation.pushViewController(nextVC, animated: true)
    }
}

extension PaymentController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.paymentCategories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = self.viewModel.paymentCategories[section]
        return self.viewModel.getPaymentCountPerCategories(with: category) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = self.viewModel.paymentCategories[indexPath.section]
        let paymentMethods = self.viewModel.getPaymentMethodPerCategories(with: category)
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withCell: PaymentHeaderCell.self, for: indexPath)
            cell.configure(with: category)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withCell: PaymentDetailCell.self, for: indexPath)
            let payment = paymentMethods[indexPath.row - 1]
            cell.configure(with: payment)
            if let selected = self.selectedIndex,
               selected == indexPath {
                cell.configureSelected()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath
        self.tableView.deselectRow(at: indexPath, animated: false)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
