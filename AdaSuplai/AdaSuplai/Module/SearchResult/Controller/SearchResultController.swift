//
//  SearchResultController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 06/10/21.
//

import UIKit

class SearchResultController: UIViewController, Identifiable {
    private enum Constant {
        static let searchPlaceholder = "Cari Penawaran"
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    init() {
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
    }
    
    private func setupNavigationBar() {
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.titleView = self.searchController.searchBar
        self.navigationItem.rightBarButtonItems = self.setupRightButtonItems()
        self.setupSearchController()
    }
    
    private func setupRightButtonItems() -> [UIBarButtonItem] {
        let wishlistButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: .some(#selector(filterTapped(_:))))
        wishlistButton.tintColor = .systemGreen
        return [wishlistButton]
    }
    
    @objc func filterTapped(_ sender: UIBarButtonItem) {
        let nextVC = FilterController()
        self.present(nextVC, animated: true)
    }
    
    private func setupSearchController() {
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.barTintColor = .systemGreen
        self.searchController.searchBar.setTextFieldColor(.secondarySystemBackground)
        self.searchController.searchBar.placeholder = Constant.searchPlaceholder
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: SearchResultCell.identifier, bundle: nil), forCellWithReuseIdentifier: SearchResultCell.identifier)
    }
}

extension SearchResultController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.identifier, for: indexPath) as? SearchResultCell else { return UICollectionViewCell() }
        if indexPath.item % 2 == 0 {
            cell.isDiscount()
        }
        return cell
    }
}

extension SearchResultController: UISearchControllerDelegate, UISearchBarDelegate {
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

extension SearchResultController: SearchNavigationDelegate {
    func goToSearchResult() {
        let nextVC = SearchResultController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
}
