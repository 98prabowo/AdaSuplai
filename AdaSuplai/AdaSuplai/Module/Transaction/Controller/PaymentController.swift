//
//  PaymentController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 15/11/21.
//

import UIKit
import Combine

class PaymentController: UIViewController {
    private enum Constant {
        static let payButton = "Bayar"
        static let totalHeader = "Total"
    }

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var priceBar: UIView!
    @IBOutlet private weak var totalTitle: UILabel!
    @IBOutlet private weak var totalPrice: UILabel!
    @IBOutlet private weak var buyButton: UIButton!
    
    private let viewModel = PaymentViewModel()
    private var subscribers = Set<AnyCancellable>()
    private var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPriceBar()
        self.setupTableView()
        self.bindViewModel()
    }
    
    private func setupPriceBar() {
        self.priceBar.addShadow()
        self.totalTitle.text = Constant.totalHeader
        self.buyButton.setTitle(Constant.payButton, for: .normal)
        self.buyButton.setTitleColor(.white, for: .normal)
        self.buyButton.backgroundColor = .primaryGreen
        self.buyButton.layer.cornerRadius = 5
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(forCell: PaymentHeaderCell.self)
        self.tableView.registerNib(forCell: PaymentDetailCell.self)
    }
    
    private func bindViewModel() {
        self.viewModel.paymentMethods
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                self.viewModel.getPaymentCategories()
                self.tableView.reloadData()
            }.store(in: &subscribers)
    }
    
    @IBAction private func buyButton(_ sender: UIButton) {
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
    }
}
