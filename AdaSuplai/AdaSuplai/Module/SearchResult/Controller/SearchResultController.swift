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
    
    private let isItemsDiscount = [true, false, false, true, true, true, false, true, false, false]
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
        self.navigationController?.navigationBar.backgroundColor = .label
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
        self.collectionView.backgroundColor = .secondarySystemBackground
        let layout = WaterfallLayout()
        layout.delegate = self
        layout.numberOfColumn = 2
        layout.horizontalContentInset = 5
        layout.verticalContentInset = 5
        self.collectionView.collectionViewLayout = layout
        self.collectionView.register(UINib(nibName: ProductCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProductCell.identifier)
    }
}

extension SearchResultController: UICollectionViewDelegate, UICollectionViewDataSource, WaterfallLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.isItemsDiscount.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: ProductCell.self, for: indexPath)
        if self.isItemsDiscount[indexPath.item] {
            cell.isDiscount()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 300
        if self.isItemsDiscount[indexPath.item] {
            height = 320
        }
        return height
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
