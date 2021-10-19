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
    private var subscribers = Set<AnyCancellable>()
    
    private lazy var searchController = UISearchController()
    
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
                    print("No Keyword found")
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
