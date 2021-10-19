//
//  AllCategoriesController.swift
//  adaSuplaiTrain
//
//  Created by Felicia Devina on 07/10/21.
//

import UIKit

class AllCategoriesController: UIViewController, Identifiable {
    
    @IBOutlet var collectionView: UICollectionView!
    var searchController = UISearchController()
    var isSearch : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setupSearchController()
        setUpCollectionView()
    }
    
    // MARK: - Navigation Bar
    
    private func setUpNavigationBar(){
        title = "Lihat Lebih"
        
        if isSearch == false {
            let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: .some(#selector(searchTapped(_:))))
            navigationItem.hidesBackButton = false
            navigationItem.hidesSearchBarWhenScrolling = false
            self.navigationItem.titleView = .none
            navigationItem.rightBarButtonItems = [searchButton]
            self.navigationController?.navigationBar.tintColor = .systemGreen
            self.navigationController?.navigationBar.backgroundColor = .white
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        } else {
            self.navigationItem.titleView = self.searchController.searchBar
            navigationItem.hidesBackButton = true
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.rightBarButtonItems = []
            self.navigationController?.navigationBar.tintColor = .systemGreen
            self.navigationController?.navigationBar.backgroundColor = .white
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
        
    }

    @objc func searchTapped(_ sender: UIBarButtonItem) {
        print("Search Tapped")
        
        isSearch = true
        setUpNavigationBar()
    }
}


// MARK: - Collection View
extension AllCategoriesController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func setUpCollectionView(){
        collectionView.register(AllCategoryCollectionCell.nib(), forCellWithReuseIdentifier: AllCategoryCollectionCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.backgroundColor = .systemGray6
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllCategoryCollectionCell.identifier, for: indexPath) as? AllCategoryCollectionCell else { return UICollectionViewCell() }
        cell.layer.cornerRadius = 8
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numRowItems:CGFloat = 2
        let padding:CGFloat = 16
        let spacing:CGFloat = 8
        let width = (collectionView.bounds.width / numRowItems) - padding - spacing
        return CGSize(width: width, height: 100)
    }
}


// MARK: - Search Bar
extension AllCategoriesController : UISearchControllerDelegate, UISearchBarDelegate  {
    
    private enum Constant {
        static let searchPlaceholder = "Cari Kategori"
    }
    
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
        
        isSearch = false
        setUpNavigationBar()
    }
}

// MARK: - END
