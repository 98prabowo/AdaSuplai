//
//  WishlistController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 22/10/21.
//

import Foundation
import UIKit

class WishlistController: BaseUIViewController {
    private enum Constant {
        static let header = "Favorit"
        static let tableIndex = 0
        static let collectionIndex = 1
        static let segmentButtons = ["Semua Produk", "Kategori"]
        static let filterButtonImage = "slider.horizontal.3"
        static let wishlistButtonImage = "plus"
    }
    
    @IBOutlet private weak var headerSegmented: AdaSuplaiSegmentedControl!
    
    private lazy var tableController = WishlistTableController()
    private lazy var collectionController = WishlistCollectionController()
    private lazy var searchController = UISearchController()
    
    private var segmentedIndex: Int = 0 {
        didSet {
            switch segmentedIndex {
            case Constant.tableIndex:
                self.addFirstChildViewController()
            case Constant.collectionIndex:
                self.addSecondChildViewController()
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupContainerView()
        self.setupHeader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.prefersLargeTitles = false
    }
    
    private func setupNavigationBar() {
        self.title = Constant.header
        self.navigationItem.searchController = self.searchController
        self.navigationItem.rightBarButtonItems = self.setupRightButtonItems()
    }
    
    private func setupRightButtonItems() -> [UIBarButtonItem] {
        let addButton = UIBarButtonItem(image: UIImage(systemName: Constant.wishlistButtonImage), style: .plain, target: self, action: .some(#selector(addTapped(_:))))
        let filterButton = UIBarButtonItem(image: UIImage(systemName: Constant.filterButtonImage), style: .plain, target: self, action: .some(#selector(filterTapped(_:))))
        filterButton.tintColor = .systemGreen
        addButton.tintColor = .systemGreen
        return [addButton, filterButton]
    }
    
    @objc private func filterTapped(_ sender: UIBarButtonItem) {
        print("FILTERED")
    }
    
    @objc private func addTapped(_ sender: UIBarButtonItem) {
        print("ADDED")
    }
    
    private func setupContainerView() {
        switch segmentedIndex {
        case Constant.tableIndex:
            self.addFirstChildViewController()
        case Constant.collectionIndex:
            self.addSecondChildViewController()
        default:
            break
        }
    }
    
    private func setupSearchController(placeholder: String, _ barColor: UIColor = .systemBackground) {
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.barTintColor = .systemGreen
        self.searchController.searchBar.setTextFieldColor(barColor)
        self.searchController.searchBar.placeholder = placeholder
    }
    
    private func setupHeader() {
        self.headerSegmented.buttonTitles = Constant.segmentButtons
    }
    
    private func addFirstChildViewController() {
        self.removeContainerView(self.collectionController)
        self.addChild(self.tableController)
        self.view.addSubview(self.tableController.view)
        self.tableController.didMove(toParent: self)
        self.tableController.view.translatesAutoresizingMaskIntoConstraints = false
        self.setupFirstChildConstraint()
    }
    
    private func addSecondChildViewController() {
        self.removeContainerView(self.tableController)
        self.addChild(self.collectionController)
        self.view.addSubview(self.collectionController.view)
        self.collectionController.didMove(toParent: self)
        self.collectionController.view.translatesAutoresizingMaskIntoConstraints = false
        self.setupSecondChildConstraint()
    }
    
    private func setupFirstChildConstraint() {
        NSLayoutConstraint.activate([
            self.tableController.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableController.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableController.view.topAnchor.constraint(equalTo: self.headerSegmented.bottomAnchor),
            self.tableController.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupSecondChildConstraint() {
        NSLayoutConstraint.activate([
            self.collectionController.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionController.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.collectionController.view.topAnchor.constraint(equalTo: self.headerSegmented.bottomAnchor),
            self.collectionController.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func removeContainerView(_ controller: UIViewController) {
        for view in self.view.subviews
        where view == controller {
            view.removeFromSuperview()
        }
    }
    
    @IBAction private func segmentDidChange(_ sender: AdaSuplaiSegmentedControl) {
        self.segmentedIndex = sender.selectedIndex
    }
}
