//
//  ListDeliveryController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 14/10/21.
//

import UIKit

class ListDeliveryController: UIViewController, Identifiable {
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTable()
    }

    private func setUpTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(forCell: DeliveryCell.self)
    }
}

extension ListDeliveryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: DeliveryCell.self, for: indexPath)
        cell.deliveryName.text = "Delivery Option \(indexPath.row + 1)"
        cell.deliveryPrice.text = "Rp. 56.000"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected == \(indexPath.row+1)")
    }
}
