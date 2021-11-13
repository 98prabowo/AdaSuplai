//
//  AllProductTransactionCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 13/10/21.
//

import UIKit

class AllProductTransactionCell: UITableViewCell {
    @IBOutlet private var mainTableView: UITableView!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var tableViewHeight: NSLayoutConstraint!
    
    private var products = [ProductCart]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsSelection = false
        self.tableView.isScrollEnabled = false
        self.tableView.registerNib(forCell: ProductTransactionCell.self)
        self.tableViewHeight.constant = CGFloat(tableView.numberOfRows(inSection: 0) * 70)
    }
    
    func configure(with products: [ProductCart]) {
        self.products = products
    }
}

extension AllProductTransactionCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: ProductTransactionCell.self, for: indexPath)
        let product = self.products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
