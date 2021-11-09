//
//  HomeController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import Foundation
import Combine
import UIKit

class HomeController: BaseUIViewController {
    private enum Constant {
        static let loading = "Loading..."
        static let searchPlaceholder = "Cari Penawaran"
        static let productTrend = "Trending Hari Ini"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = HomeViewModel()
    private let loading = LoadingController().createLoading(with: Constant.loading)
    private var subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLoading()
        self.setupNavigationBar()
        self.setupTableView()
        self.bindToViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .primaryGreen
        navigation.navigationBar.barTintColor = .primaryGreen
        navigation.navigationBar.tintColor = .systemBackground
        self.view.backgroundColor = .primaryGreen
        self.addSearchBar(placeholder: Constant.searchPlaceholder)
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .blueBackground
        self.tableView.registerNib(forCell: HomeCategoryCell.self)
        self.tableView.registerNib(forCell: BannerPromoCell.self)
        self.tableView.registerNib(forCell: HotProductCell.self)
    }
    
    private func setupLoading() {
        self.present(self.loading, animated: true)
    }
    
    private func bindToViewModel() {
        self.viewModel.productTrends
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                self.tableView.reloadData()
                self.loading.dismiss(animated: true)
            }.store(in: &subscribers)
        self.viewModel.suppliers
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                self.tableView.reloadData()
                self.loading.dismiss(animated: true)
            }.store(in: &subscribers)
    }
    
    private func goToCategoryController(index: Int) {
        let nextVC = CategoryController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
    
    private func goToMoreCategoryController() {
        let nextVC = SeeMoreCategoryController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
    
    private func goToBannerController() {
        // TODO: Assign BannerVC to nextVC
//        let nextVC = UIViewController()
//        if let navigationController = self.navigationController {
//            navigationController.pushViewController(nextVC, animated: true)
//        }
    }
    
    private func goToProductController(with product: Product) {
        let nextVC = ProductController(product: product)
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
                .sink { [unowned self] value in
                    switch value {
                    case .seeMore:
                        self.goToMoreCategoryController()
                    case .category(index: let index):
                        self.goToCategoryController(index: index)
                    }
                }
                .store(in: &subscribers)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withCell: BannerPromoCell.self, for: indexPath)
            cell.bannerPublisher
                .sink { [unowned self] in
                    self.goToBannerController()
                }
                .store(in: &subscribers)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withCell: HotProductCell.self, for: indexPath)
            cell.configure(with: self.viewModel.productTrends.value,
                           suppliers: self.viewModel.suppliers.value,
                           title: Constant.productTrend)
            cell.productPublisher
                .sink { [unowned self] product in
                    self.goToProductController(with: product)
                }
                .store(in: &subscribers)
            return cell
        }
    }
}
