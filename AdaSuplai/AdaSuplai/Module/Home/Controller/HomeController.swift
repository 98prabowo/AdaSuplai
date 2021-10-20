//
//  HomeController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import Foundation
import UIKit
import Combine

class HomeController: BaseUIViewController {
    private enum Constant {
        static let searchPlaceholder = "Cari Penawaran"
        static let productTrend = "Trending Hari Ini"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = HomeViewModel()
    private var homeTokens = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .primaryGreen
        navigation.navigationBar.barTintColor = .primaryGreen
        self.view.backgroundColor = .primaryGreen
        self.addSearchBar(placeholder: Constant.searchPlaceholder)
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(forCell: HomeCategoryCell.self)
        self.tableView.registerNib(forCell: BannerPromoCell.self)
        self.tableView.registerNib(forCell: HotProductCell.self)
    }
    
    private func goToCategoryController() {
        // TODO: Assign CategoryVC to nextVC
//        let nextVC = UIViewController()
//        if let navigationController = self.navigationController {
//            navigationController.pushViewController(nextVC, animated: true)
//        }
    }
    
    private func goToBannerController() {
        // TODO: Assign BannerVC to nextVC
        let nextVC = TransactionDetailController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
    
    private func goToProductController() {
        let nextVC = ProductController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withCell: HomeCategoryCell.self, for: indexPath)
            cell.configure(categories: self.viewModel.categories)
            cell.categoryPublisher
                .sink { [unowned self] in
                    self.goToCategoryController()
                }
                .store(in: &homeTokens)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withCell: BannerPromoCell.self, for: indexPath)
            cell.bannerPublisher
                .sink { [unowned self] in
                    self.goToBannerController()
                }
                .store(in: &homeTokens)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withCell: HotProductCell.self, for: indexPath)
            cell.configure(with: self.viewModel.todayTrends, title: Constant.productTrend)
            cell.productPublisher
                .sink { [unowned self] in
                    self.goToProductController()
                }
                .store(in: &homeTokens)
            return cell
        }
    }
}
