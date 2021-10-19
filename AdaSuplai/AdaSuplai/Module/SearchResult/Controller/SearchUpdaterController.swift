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
        self.tableView.registerNib(forCell: SearchUpdaterLastSeenCell.self)
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
                print(value)
            }
            .store(in: &searchSubscriber)
    }
}

extension SearchUpdaterController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: SearchUpdaterLastSeenCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.configure(history: self.viewModel.keyword)
        return cell
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
