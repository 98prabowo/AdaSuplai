//
//  FilterController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import UIKit

class FilterController: BaseUIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    init() {
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(forCell: FilterHeaderCell.self)
        self.tableView.registerNib(forCell: FilterCell.self)
        self.tableView.registerNib(forCell: FilterPriceRangeCell.self)
        self.tableView.registerNib(forCell: SpacerFilterCell.self)
        self.tableView.registerNib(forCell: SubmitButtonCell.self)
    }
}

extension FilterController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withCell: FilterHeaderCell.self, for: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withCell: FilterCell.self, for: indexPath)
            // Sort
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withCell: FilterCell.self, for: indexPath)
            // Location
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withCell: FilterPriceRangeCell.self, for: indexPath)
            // Price Range
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withCell: FilterCell.self, for: indexPath)
            // Rating
            return cell
        case 9:
            let cell = tableView.dequeueReusableCell(withCell: FilterCell.self, for: indexPath)
            // Min. Order
            return cell
        case 11:
            let cell = tableView.dequeueReusableCell(withCell: FilterCell.self, for: indexPath)
            // Category
            return cell
        case 13:
            let cell = tableView.dequeueReusableCell(withCell: FilterCell.self, for: indexPath)
            // Others
            return cell
        case 14:
            let cell = tableView.dequeueReusableCell(withCell: SubmitButtonCell.self, for: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withCell: SpacerFilterCell.self, for: indexPath)
            return cell
        }
    }
}
