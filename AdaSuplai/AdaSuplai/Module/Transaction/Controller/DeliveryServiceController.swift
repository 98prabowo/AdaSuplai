//
//  DeliveryServiceController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 14/10/21.
//

import UIKit

class DeliveryServiceController: BaseUIViewController {
    private enum Constant {
        static let title = "Pilihan Pengiriman"
    }
    
    @IBOutlet private weak var header: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = DeliveryServiceViewModel()
    private var selectedIndex: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: DeliveryCell.self, for: indexPath)
        cell.configure()
        if let selected = self.selectedIndex,
           selected == indexPath {
            cell.configureSelected()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath
        self.tableView.deselectRow(at: indexPath, animated: false)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.dismiss(animated: true)
    }
}
