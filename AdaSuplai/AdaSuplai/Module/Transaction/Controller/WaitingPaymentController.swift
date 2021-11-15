//
//  WaitingPaymentController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 15/11/21.
//

import UIKit

class WaitingPaymentController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = WaitingPaymentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(forCell: WaitingPaymentHeaderCell.self)
        self.tableView.registerNib(forCell: WaitingPaymentMethodCell.self)
        self.tableView.registerNib(forCell: WaitingPaymentButtonsCell.self)
        self.tableView.registerNib(forCell: WaitingPaymentGuidlineHeaderCell.self)
        self.tableView.registerNib(forCell: WaitingPaymentGuidlineDetailCell
                                    .self)
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
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withCell: WaitingPaymentGuidlineHeaderCell.self, for: indexPath)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withCell: WaitingPaymentButtonsCell.self, for: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withCell: WaitingPaymentGuidlineDetailCell.self, for: indexPath)
            return cell
        }
    }
}
