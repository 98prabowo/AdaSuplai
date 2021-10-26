//
//  MoreSortFilterCategoryController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 25/10/21.
//

import UIKit
import Combine

class MoreSortFilterCategoryController: UIViewController, Identifiable {
    private enum Constant {
        static let header = "Lokasi Suplier"
        static let implementButton = "Terapkan"
        static let searchPlaceholder = "Cari"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var subscribers = Set<AnyCancellable>()
    private let viewModel: MoreSortFilterCategoryViewModel
    
    init(keys: [String]) {
        self.viewModel = MoreSortFilterCategoryViewModel(keys: keys)
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTableView()
        self.bindViewModel()
    }
    
    private func setupNavigationBar() {
        self.title = Constant.header
        self.navigationItem.rightBarButtonItems = self.getBarButtons()
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.setupSearchBar()
    }
    
    private func getBarButtons() -> [UIBarButtonItem] {
        var result = [UIBarButtonItem]()
        let implementButton = UIBarButtonItem(title: Constant.implementButton, style: .plain, target: self, action: #selector(implement(_:)))
        implementButton.tintColor = .primaryGreen
        result.append(implementButton)
        return result
    }
    
    private func setupSearchBar() {
        self.searchController.loadViewIfNeeded()
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.definesPresentationContext = true
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(forCell: MoreCategorySortFilterCell.self)
    }
    
    private func bindViewModel() {
        self.viewModel.tablePublisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] in
                self.tableView.reloadData()
            }
            .store(in: &subscribers)
    }
    
    @objc private func implement(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
            print("Implemented")
        }
    }
}

extension MoreSortFilterCategoryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.filteredKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: MoreCategorySortFilterCell.self, for: indexPath)
        let key = self.viewModel.filteredKeys[indexPath.row]
        cell.configure(key: key)
        return cell
    }
}

extension MoreSortFilterCategoryController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if let searchText = searchBar.text {
            if !searchText.isEmpty {
                self.viewModel.filteredKeys = self.viewModel.keys.filter({ key in
                    return key.localizedLowercase.contains(searchText.localizedLowercase)
                })
            } else {
                self.viewModel.filteredKeys = self.viewModel.keys
            }
        }
    }
}
