//
//  BaseUIViewController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 30/09/21.
//

import Foundation
import Combine
import UIKit

class BaseUIViewController: UIViewController, Identifiable {
    private enum Constant {
        static let searchButton = "magnifyingglass"
        static let noKeywordError = "No Keyword found"
    }
    
    private var subscribers = Set<AnyCancellable>()
    private lazy var searchController = UISearchController()
    
    /// Add searchbar and it's features to navigation bar. it will delete title functionality.
    ///
    /// - Parameters:
    ///   - buttons: Array of right button item. Default is nil (no button will be added).
    ///   - placeholder: A placeholder for searchbar in `String`.
    ///   - barColor: Color for searchbar. Default to system background color.
    func addSearchBar(with buttons: [UIBarButtonItem]? = nil, placeholder: String, barColor: UIColor = .systemBackground) {
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.titleView = self.searchController.searchBar
        self.navigationItem.rightBarButtonItems = buttons
        self.setupSearchController(placeholder: placeholder, barColor)
    }
    
    /// Add search button and it's features to navigationbar.
    ///
    /// - Parameters:
    ///   - tintColor: Color for search button. Default to system primary green color.
    func addSearchButton(tintColor: UIColor = .primaryGreen) {
        let searchButton = UIBarButtonItem(image: UIImage(systemName: Constant.searchButton), style: .plain, target: self, action: #selector(goToSearchUpdater(_:)))
        searchButton.tintColor = tintColor
        self.navigationItem.rightBarButtonItems = [searchButton]
    }
    
    private func setupSearchController(placeholder: String, _ barColor: UIColor = .systemBackground) {
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.barTintColor = .systemGreen
        self.searchController.searchBar.setTextFieldColor(barColor)
        self.searchController.searchBar.placeholder = placeholder
    }
    
    @objc private func goToSearchUpdater(_ sender: UIBarButtonItem) {
        let nextVC = SearchUpdaterController()
        nextVC.searchPublisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(.noKeywordError):
                    print(Constant.noKeywordError)
                }
            } receiveValue: { value in
                self.goToSearchResult(keyword: value)
            }
            .store(in: &subscribers)
        
        let navController = UINavigationController(rootViewController: nextVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: false, completion: nil)
    }
    
    private func goToSearchResult(keyword: String) {
        let nextVC = SearchResultController(keyword: keyword)
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
}

extension BaseUIViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let nextVC = SearchUpdaterController()
        nextVC.searchPublisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(.noKeywordError):
                    print(Constant.noKeywordError)
                }
            } receiveValue: { value in
                self.goToSearchResult(keyword: value)
            }
            .store(in: &subscribers)
        
        let navController = UINavigationController(rootViewController: nextVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: false, completion: nil)
    }
}
