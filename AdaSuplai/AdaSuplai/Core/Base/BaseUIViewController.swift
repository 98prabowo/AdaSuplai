//
//  BaseUIViewController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 30/09/21.
//

import Foundation
import UIKit

class BaseUIViewController: UIViewController, Identifiable {
    lazy var searchController = UISearchController()
    
    func addSearchBar(with buttons: [UIBarButtonItem]? = nil, placeholder: String, barColor: UIColor = .systemBackground) {
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.titleView = self.searchController.searchBar
        self.navigationItem.rightBarButtonItems = buttons
        self.setupSearchController(placeholder: placeholder, barColor)
    }
    
    private func setupSearchController(placeholder: String, _ barColor: UIColor = .systemBackground) {
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.barTintColor = .systemGreen
        self.searchController.searchBar.setTextFieldColor(barColor)
        self.searchController.searchBar.placeholder = placeholder
    }
}

extension BaseUIViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let nextVC = SearchUpdaterController()
        nextVC.homeDelegate = self
        let navController = UINavigationController(rootViewController: nextVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: false, completion: nil)
    }
}

extension BaseUIViewController: SearchNavigationDelegate {
    func goToSearchResult() {
        let nextVC = SearchResultController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
}
