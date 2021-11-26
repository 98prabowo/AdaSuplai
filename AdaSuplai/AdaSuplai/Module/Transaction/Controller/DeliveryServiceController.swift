//
//  DeliveryServiceController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 14/10/21.
//

import UIKit
import Combine

class DeliveryServiceController: BaseUIViewController {
    private enum Constant {
        static let title = "Pilihan Pengiriman"
    }
    
    @IBOutlet private weak var header: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    var deliveryPublisher = PassthroughSubject<ShipmentPrice, Never>()
    private let viewModel: DeliveryServiceViewModel
    
    init(with shipmentPrice: [ShipmentPrice]) {
        self.viewModel = DeliveryServiceViewModel(with: shipmentPrice)
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBackground()
        self.setupTableView()
    }
    
    private func setupBackground() {
        self.title = Constant.title
    }

    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerNib(forCell: DeliveryCell.self)
    }
}

extension DeliveryServiceController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.shipmentPrices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: DeliveryCell.self, for: indexPath)
        let shipmentPrice = self.viewModel.shipmentPrices[indexPath.row]
        cell.configure(with: shipmentPrice)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var shipmentPrice = self.viewModel.shipmentPrices[indexPath.row]
        shipmentPrice.createdDate = Date()
        self.tableView.deselectRow(at: indexPath, animated: false)
        self.deliveryPublisher.send(shipmentPrice)
        self.dismiss(animated: true)
    }
}
