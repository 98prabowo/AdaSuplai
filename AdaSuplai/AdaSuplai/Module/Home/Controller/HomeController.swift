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
    
    var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTableView()
    }
    
    private func setupNavigationBar() {
        let wishlistButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: .some(#selector(wishlistTapped(_:))))
        wishlistButton.tintColor = .systemBackground
        navigationItem.hidesBackButton = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.titleView = searchController.searchBar
        navigationItem.rightBarButtonItems = [wishlistButton]
        self.navigationController?.navigationBar.backgroundColor = .systemGreen
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setupSearchController()
    }
    
    @objc func wishlistTapped(_ sender: UIBarButtonItem) {
        print("Wishlist Tapped")
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
extension HomeController: UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let nextVC = SearchUpdaterController(nibName: SearchUpdaterController.identifier, bundle: nil)
        let navController = UINavigationController(rootViewController: nextVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: false, completion: nil)
    }
}

extension UISearchBar {
    func setTextFieldColor(_ color: UIColor) {
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = color
        }
    }
}
