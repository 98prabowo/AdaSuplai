//
//  FilterController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import UIKit
import Combine
import SwiftUI

enum FilterCellIndex {
    static let header = 0
    static let sort = 1
    static let location = 3
    static let priceRange = 5
    static let rating = 7
    static let minOrder = 9
    static let category = 11
    static let others = 13
    static let submitButton = 14
}

class FilterController: BaseUIViewController {
    fileprivate enum Constant {
        static let sort = "Urutkan"
        static let location = "Lokasi Supplier"
        static let priceRange = "Harga"
        static let rating = "Rating"
        static let minimumOrder = "Minimum Order"
        static let category = "Kategori"
        static let others = "Lainnya"
        static let submitTitle = "Terapkan"
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var subscribers = Set<AnyCancellable>()
    private let viewModel: FilterViewModel
    
    init() {
        viewModel = FilterViewModel()
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(forCell: FilterHeaderCell.self)
        self.tableView.registerNib(forCell: FilterCell.self)
        self.tableView.registerNib(forCell: FilterPriceRangeCell.self)
        self.tableView.registerNib(forCell: SpacerFilterCell.self)
        self.tableView.registerNib(forCell: SubmitButtonCell.self)
    }
    
    private func goToMoreFilter(from type: Int) {
        var filterKeys = [String]()
        switch type {
        case FilterCellIndex.location:
            filterKeys = self.viewModel.locations
        case FilterCellIndex.category:
            // TODO: add more category in view model then change filter keys in here
            break
        default:
            break
        }
        
        let nextVC = MoreSortFilterCategoryController(keys: filterKeys)
        let navController = UINavigationController(rootViewController: nextVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true)
    }
}

extension FilterController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case FilterCellIndex.header:
            return self.setupHeaderCell(tableView, for: indexPath)
        case FilterCellIndex.sort:
            return self.setupSortCell(tableView, for: indexPath)
        case FilterCellIndex.location:
            return self.setupLocationCell(tableView, for: indexPath)
        case FilterCellIndex.priceRange:
            return self.setupPriceRangeCell(tableView, for: indexPath)
        case FilterCellIndex.rating:
            return self.setupRatingCell(tableView, for: indexPath)
        case FilterCellIndex.minOrder:
            return self.setupMinOrderCell(tableView, for: indexPath)
        case FilterCellIndex.category:
            return self.setupCategoryCell(tableView, for: indexPath)
        case FilterCellIndex.others:
            return self.setupOthersCell(tableView, for: indexPath)
        case FilterCellIndex.submitButton:
            return self.setupSubmitCell(tableView, for: indexPath)
        default:
            return self.setupSpacerCell(tableView, for: indexPath)
        }
    }
}

// MARK: - Setup Table Cell
extension FilterController {
    private func setupHeaderCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: FilterHeaderCell.self, for: indexPath)
        cell.publisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] action in
                switch action {
                case .reset:
                    print("RESET")
                case .close:
                    self.dismiss(animated: true)
                }
            }
            .store(in: &subscribers)
        return cell
    }
    
    private func setupSortCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: FilterCell.self, for: indexPath)
        cell.configure(title: Constant.sort,
                       filterKeys: ["Penjualan Tertinggi", "Penjualan Termurah", "Harga Tergtinggi", "Harga Termurah", "Rating Tertinggi"])
        return cell
    }
    
    private func setupLocationCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: FilterCell.self, for: indexPath)
        cell.showSeeMore()
        cell.configure(title: Constant.location,
                       filterKeys: self.viewModel.locations,
                       type: FilterCellIndex.location)
        cell.publisher
            .sink { [unowned self] in
                self.goToMoreFilter(from: FilterCellIndex.location)
            }
            .store(in: &subscribers)
        return cell
    }
    
    private func setupPriceRangeCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: FilterPriceRangeCell.self, for: indexPath)
        cell.configure(title: Constant.priceRange)
        return cell
    }
    
    private func setupRatingCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: FilterCell.self, for: indexPath)
        cell.showRating()
        cell.configure(title: Constant.rating,
                       filterKeys: ["5", "4 ke atas", "3 ke atas", "2 ke atas", "1 ke atas"])
        return cell
    }
    
    private func setupMinOrderCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: FilterCell.self, for: indexPath)
        cell.configure(title: Constant.minimumOrder,
                       filterKeys: ["Tanpa min. Order", "100", "1000"])
        return cell
    }
    
    private func setupCategoryCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: FilterCell.self, for: indexPath)
        cell.showSeeMore()
        cell.configure(title: Constant.category,
                       filterKeys: ["Biji Kopi", "Bubuk", "Susu", "Gula", "Cokelat"])
        cell.publisher
            .sink { [unowned self] in
                self.goToMoreFilter(from: FilterCellIndex.category)
            }
            .store(in: &subscribers)
        return cell
    }
    
    private func setupOthersCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: FilterCell.self, for: indexPath)
        cell.configure(title: Constant.others,
                       filterKeys: ["Preorder", "Ready Stock", "Gratis Ongkir"])
        return cell
    }
    
    private func setupSubmitCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: SubmitButtonCell.self, for: indexPath)
        cell.configure(title: Constant.submitTitle)
        cell.publisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] in
                self.dismiss(animated: true, completion: nil)
            }
            .store(in: &subscribers)
        return cell
    }
    
    private func setupSpacerCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: SpacerFilterCell.self, for: indexPath)
        return cell
    }
}
