//
//  AllCategoriesController.swift
//  adaSuplaiTrain
//
//  Created by Felicia Devina on 07/10/21.
//

import UIKit

class SeeMoreCategoryController: UIViewController, Identifiable {
    
    @IBOutlet var collectionView: UICollectionView!
    var searchController = UISearchController()
    
    private enum Constant {
        static let searchPlaceholder = "Cari Kategori"
        static var isSearch: Bool = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setupSearchController()
        setUpCollectionView()
    }
    
    // MARK: - Navigation Bar
    
    private func setUpNavigationBar() {
        title = "Lihat Lebih"
        
        if Constant.isSearch == false {
            guard let navigation = self.navigationController else { return }
            navigation.navigationBar.backgroundColor = .white
            navigation.navigationBar.barTintColor = .white
            self.view.backgroundColor = .white
            self.navigationController?.navigationBar.tintColor = .primaryGreen
            
            let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: .some(#selector(searchTapped(_:))))
            navigationItem.hidesBackButton = false
            navigationItem.hidesSearchBarWhenScrolling = false
            self.navigationItem.titleView = .none
            navigationItem.rightBarButtonItems = [searchButton]
        } else {
            guard let navigation = self.navigationController else { return }
            navigation.navigationBar.backgroundColor = .white
            navigation.navigationBar.barTintColor = .white
            self.view.backgroundColor = .white
            
            self.navigationItem.titleView = self.searchController.searchBar
            navigationItem.hidesBackButton = true
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.rightBarButtonItems = []
        }
        
    }
    
    @objc func searchTapped(_ sender: UIBarButtonItem) {
        print("Search Tapped")
        
        Constant.isSearch = true
        setUpNavigationBar()
    }
}

// MARK: - Collection View
extension SeeMoreCategoryController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setUpCollectionView() {
        collectionView.registerNib(forCell: SeeMoreCategoryCollectionCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .blueBackground
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: SeeMoreCategoryCollectionCell.self, for: indexPath)
        return cell
    }
    
    // CollectionView Dynamic Sizing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numRowItems: CGFloat = 2
        let padding: CGFloat = 16
        let spacing: CGFloat = 8
        let width = (collectionView.bounds.width / numRowItems) - padding - spacing
        return CGSize(width: width, height: 100)
    }
}

// MARK: - Search Bar
extension SeeMoreCategoryController: UISearchControllerDelegate, UISearchBarDelegate {
    private func setupSearchController() {
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.showsCancelButton = true
        self.searchController.searchBar.barTintColor = .systemGreen
        self.searchController.searchBar.placeholder = Constant.searchPlaceholder
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel")
        
        Constant.isSearch = false
        setUpNavigationBar()
    }
}

// MARK: - END
