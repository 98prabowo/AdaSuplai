//
//  SearchUpdaterController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 06/10/21.
//

import UIKit

class SearchUpdaterController: UIViewController, Identifiable {
    @IBOutlet private weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchText: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchController.isActive = true
    }
    
    private func setupNavigationBar() {
        self.navigationItem.searchController = self.searchController
        self.setupSearchBar()
    }
    
    private func setupSearchBar() {
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: SearchUpdaterLastSeenCell.identifier, bundle: nil), forCellReuseIdentifier: SearchUpdaterLastSeenCell.identifier)
    }
}

extension SearchUpdaterController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: false, completion: nil)
    }
}

extension SearchUpdaterController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchUpdaterLastSeenCell.identifier, for: indexPath) as? SearchUpdaterLastSeenCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(history: self.searchText)
        return cell
    }
}