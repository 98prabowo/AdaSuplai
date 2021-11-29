//
//  WishlistTableController.swift
//  AdaSuplai
//
//  Created by dimas.prabowo on 21/11/21.
//

import UIKit

class WishlistTableController: BaseUIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = WishlistTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .blueBackground
        self.tableView.registerNib(forCell: WishlistTableCell.self)
    }
}

extension WishlistTableController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: WishlistTableCell.self, for: indexPath)
        let product = self.viewModel.products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
}
