//
//  WaitingPaymentController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 15/11/21.
//

import UIKit
import Combine

class WaitingPaymentController: BaseUIViewController {
    private enum Constant {
        static let header = "Menunggu Pembayaran"
        static let guidelineCell = "Cara Pembayaran"
        static let guidlineHeaders = ["ATM", "Internet Banking", "M-Banking"]
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var paymentWaitSubscribers = Set<AnyCancellable>()
    private let viewModel: WaitingPaymentViewModel
    
    private var segmentIndex: Int? {
        didSet {
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: 3, section: 0)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    init(payment: Payment) {
        self.viewModel = WaitingPaymentViewModel(payment: payment)
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTableView()
        self.bindViewModel()
    }
    
    private func setupNavigationBar() {
        self.title = Constant.header
//        self.navigationItem.hidesBackButton = true
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .blueBackground
        self.tableView.registerNib(forCell: WaitingPaymentHeaderCell.self)
        self.tableView.registerNib(forCell: WaitingPaymentMethodCell.self)
        self.tableView.registerNib(forCell: WaitingPaymentButtonsCell.self)
        self.tableView.registerNib(forCell: WaitingPaymentGuidlineHeaderCell.self)
        self.tableView.registerNib(forCell: WaitingPaymentGuidlineDetailCell
                                    .self)
    }
    
    private func bindViewModel() {
        self.viewModel.paymentInstructions
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] value in
                if !value.isEmpty, self.segmentIndex == nil {
                    self.segmentIndex = 0
                }
                self.tableView.reloadData()
            }.store(in: &paymentWaitSubscribers)
    }
}

extension WaitingPaymentController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withCell: WaitingPaymentHeaderCell.self, for: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withCell: WaitingPaymentMethodCell.self, for: indexPath)
            cell.vaCodePublisher
                .sink { vaCode in
                    UIPasteboard.general.string = vaCode
                }.store(in: &paymentWaitSubscribers)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withCell: WaitingPaymentGuidlineHeaderCell.self, for: indexPath)
            cell.configure(with: Constant.guidelineCell,
                           segmentTitles: Constant.guidlineHeaders)
            cell.guidelineHeaderPublisher
                .sink { [unowned self] index in
                    self.segmentIndex = index
                }.store(in: &paymentWaitSubscribers)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withCell: WaitingPaymentButtonsCell.self, for: indexPath)
            cell.waitingPaymentPublisher
                .sink { actions in
                    switch actions {
                    case .firstTapped:
                        print("BAYAR")
                    case .secondTapped:
                        print("BELANJA LAGI")
                    }
                }.store(in: &paymentWaitSubscribers)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withCell: WaitingPaymentGuidlineDetailCell.self, for: indexPath)
            if let index = self.segmentIndex {
                let instruction = self.viewModel.paymentInstructions.value[index]
                cell.configure(with: instruction)
            }
            return cell
        }
    }
}
