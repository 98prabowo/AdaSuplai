//
//  HomeController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import Foundation
import UIKit

class HomeController: BaseUIViewController {
    private enum Constant {
        static let searchPlaceholder = "Cari Penawaran"
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupSearchController()
        self.setupTableView()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupSearchController() {
        self.searchController.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.placeholder = Constant.searchPlaceholder
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(HomeCategoryCell.nib(), forCellReuseIdentifier: HomeCategoryCell.identifier)
        self.tableView.register(BannerPromoCell.nib(), forCellReuseIdentifier: BannerPromoCell.identifier)
        self.tableView.register(HotProductCell.nib(), forCellReuseIdentifier: HotProductCell.identifier)
    }
}

// MARK: - TableView
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCategoryCell.identifier, for: indexPath) as? HomeCategoryCell else { return UITableViewCell() }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerPromoCell.identifier, for: indexPath) as? BannerPromoCell else { return UITableViewCell() }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HotProductCell.identifier, for: indexPath) as? HotProductCell else { return UITableViewCell() }
            return cell
        }
    }
}

// MARK: - Search Controller
extension HomeController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            self.searchController.searchResultsController?.view.isHidden = false
        }
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        self.searchController.searchResultsController?.view.isHidden = false
    }
    
}
