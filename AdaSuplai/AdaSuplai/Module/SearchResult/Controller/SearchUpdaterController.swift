//
//  SearchUpdaterController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 06/10/21.
//

import UIKit
import Combine

enum SearchError: Error {
    case noKeywordError
}

class SearchUpdaterController: UIViewController, Identifiable {
    private enum Constant {
        static let cancelButton = "Batal"
        static let cancelButtonKey = "cancelButtonText"
        static let searchHistoryEntity = "SearchHistory"
        static let searchHistoryHeader = "Terakhir Dicari"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    let searchPublisher = PassthroughSubject<String, SearchError>()
    private var searchSubscriber = Set<AnyCancellable>()
    private let viewModel: SearchUpdaterViewModel
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    init() {
        self.viewModel = SearchUpdaterViewModel()
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTableView()
        self.searchTextFieldListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchController.isActive = true
    }
    
    private func setupNavigationBar() {
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .systemBackground
        navigation.navigationBar.barTintColor = .systemBackground
        navigation.navigationBar.tintColor = .primaryGreen
        self.navigationItem.searchController = self.searchController
        self.setupSearchBar()
    }
    
    private func setupSearchBar() {
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.setValue(Constant.cancelButton, forKey: Constant.cancelButtonKey)
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(forCell: SearchHistoryHeaderCell.self)
        self.tableView.registerNib(forCell: SearchHistoryCell.self)
    }
    
    private func searchTextFieldListener() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
        publisher
            .compactMap {
                ($0.object as? UISearchTextField)?.text
            }
            .receive(on: DispatchQueue.main)
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [unowned self] value in
                self.viewModel.keyword = value
                self.tableView.reloadData()
            }
            .store(in: &searchSubscriber)
    }
}

extension SearchUpdaterController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.searchHistory.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0:
            let cell = tableView.dequeueReusableCell(withCell: SearchHistoryHeaderCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.configure(header: Constant.searchHistoryHeader)
            cell.deleteAllHistory = { [unowned self] in
                self.viewModel.resetAllRecords(in: Constant.searchHistoryEntity)
                self.viewModel.fetchSearchHistory()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withCell: SearchHistoryCell.self, for: indexPath)
            let history = self.viewModel.searchHistory[indexPath.row - 1]
            cell.configure(history: history.searchKey)
            cell.deleteHistory = { [unowned self] in
                self.viewModel.deleteData(history)
                self.viewModel.fetchSearchHistory()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.dismiss(animated: false)
        self.dismiss(animated: false) { [weak self] in
            guard let keyword = self?.viewModel.searchHistory[indexPath.row - 1].searchKey else { return }
            self?.searchPublisher.send(keyword)
        }
    }
}

extension SearchUpdaterController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: false)
        self.dismiss(animated: false) { [weak self] in
            if let keyword = searchBar.text {
                self?.searchPublisher.send(keyword)
            } else {
                self?.searchPublisher.send(completion: .failure(.noKeywordError))
            }
        }
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
}
