//
//  AllProductTransactionCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 13/10/21.
//

import UIKit

class AllProductTransactionCell: UITableViewCell {
    
    @IBOutlet var mainTableView: UITableView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    var isLast: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpTable()
        
    }
    
    private func setUpTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        
        tableView.register(ProductTransactionCell.nib(), forCellReuseIdentifier: ProductTransactionCell.identifier)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

extension AllProductTransactionCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: ProductTransactionCell.self, for: indexPath)
        cell.productTotal.text = "x \(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == indexPath.last {
            self.tableViewHeight.constant = self.tableView.contentSize.height
            print("\(self.tableViewHeight.constant) == Heya \(tableView.contentSize.height)")
        }
        
        if isLast {
            mainTableView.reloadData()
        }
    }
}
