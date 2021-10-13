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
        static let productTrend = "Trending Hari Ini"
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController()
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backgroundColor = .systemGreen
    }
    
    private func setupNavigationBar() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.titleView = searchController.searchBar
        self.setupSearchController()
    }
    
    private func setupSearchController() {
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.barTintColor = .systemGreen
        self.searchController.searchBar.setTextFieldColor(.systemBackground)
        self.searchController.searchBar.placeholder = Constant.searchPlaceholder
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(forCell: HomeCategoryCell.self)
        self.tableView.registerNib(forCell: BannerPromoCell.self)
        self.tableView.registerNib(forCell: HotProductCell.self)
    }
}

// MARK: - TableView
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withCell: HomeCategoryCell.self, for: indexPath)
            cell.configure(categories: self.viewModel.categories)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withCell: BannerPromoCell.self, for: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withCell: HotProductCell.self, for: indexPath)
            cell.configure(with: self.viewModel.todayTrends, title: Constant.productTrend)
            return cell
        }
    }
}

// MARK: - Search Controller
extension HomeController: UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let nextVC = SearchUpdaterController()
        nextVC.homeDelegate = self
        let navController = UINavigationController(rootViewController: nextVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: false, completion: nil)
    }
}

extension HomeController: SearchNavigationDelegate {
    func goToSearchResult() {
        let nextVC = SearchResultController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
}
