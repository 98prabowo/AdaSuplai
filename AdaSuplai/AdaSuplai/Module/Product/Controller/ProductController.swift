//
//  ProductController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 13/10/21.
//

import UIKit
import Combine

enum ProductDetailCellIndex {
    static let imagePrice = 0
    static let status = 1
    static let variant = 2
    static let attributesHeader = 3
    static let supplier = 5
    static let reviewHeader = 6
    static let reviewDetail = 7
    static let similar = 8
}

class ProductController: BaseUIViewController {
    private enum Constant {
        static let searchPlaceholder = "Cari"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var buyButton: UIButton!
    @IBOutlet private weak var addToCart: UIButton!
    
    private var attributeToken = Set<AnyCancellable>()
    private var attribute: ProductAttribute = .description
    private let viewModel: ProductViewModel
    
    init() {
        self.viewModel = ProductViewModel()
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupButton()
        self.setupTableView()
        self.setupBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
        self.setupBackground()
    }
    
    private func setupBackground() {
        self.tableView.backgroundColor = .blueBackground
    }
    
    private func setupNavigationBar() {
        let wishlistButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(wishlistButtonTapped(_:)))
        wishlistButton.tintColor = .primaryGreen
        let cartButton = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(cartButtonTapped(_:)))
        cartButton.tintColor = .primaryGreen
        self.addSearchBar(with: [cartButton, wishlistButton],
                          placeholder: Constant.searchPlaceholder,
                          barColor: .systemGray5)
        
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .systemBackground
    }
    
    private func setupButton() {
        self.addToCart.backgroundColor = .primaryGreen
        self.addToCart.setTitleColor(.systemBackground, for: .normal)
        self.addToCart.layer.cornerRadius = 5
        self.buyButton.backgroundColor = .systemBackground
        self.buyButton.setTitleColor(.primaryGreen, for: .normal)
        self.buyButton.addBorderAndCornerRadius(withBorderWidth: 1, borderColor: .primaryGreen, cornerRadius: 5)
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(forCell: ProductImagePriceCell.self)
        self.tableView.registerNib(forCell: StaticStatusProductCell.self)
        self.tableView.registerNib(forCell: ProductVariantCell.self)
        self.tableView.registerNib(forCell: ProductAttributesHeaderCell.self)
        self.tableView.registerNib(forCell: ProductAttributesDescriptionCell.self)
        self.tableView.registerNib(forCell: ProductAttributesDetailCell.self)
        self.tableView.registerNib(forCell: ProductAttributesDeliveryCell.self)
        self.tableView.registerNib(forCell: ProductSupplierCell.self)
        self.tableView.registerNib(forCell: ProductReviewCell.self)
        self.tableView.registerNib(forCell: ProductReviewDetailCell.self)
        self.tableView.registerNib(forCell: SimilarProductCell.self)
    }
    
    @objc private func wishlistButtonTapped(_ sender: UIBarButtonItem) {
        print("Go To Wishlist")
    }
    
    @objc private func cartButtonTapped(_ sender: UIBarButtonItem) {
        print("Go To Cart")
    }
    
    @IBAction func buyButtonTapped(_ sender: UIButton) {
        print("Buy")
    }
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        print("Add to Cart")
    }
}

extension ProductController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case ProductDetailCellIndex.imagePrice:
            return self.setupImagePriceCell(tableView, for: indexPath)
        case ProductDetailCellIndex.status:
            return self.setupStatusCell(tableView, for: indexPath)
        case ProductDetailCellIndex.variant:
            return self.setupVariantCell(tableView, for: indexPath)
        case ProductDetailCellIndex.attributesHeader:
            return self.setupAttributeHeaderCell(tableView, for: indexPath)
        case ProductDetailCellIndex.supplier:
            return self.setupSupplierCell(tableView, for: indexPath)
        case ProductDetailCellIndex.reviewHeader:
            return self.setupReviewHeaderCell(tableView, for: indexPath)
        case ProductDetailCellIndex.reviewDetail:
            return self.setupReviewDetailCell(tableView, for: indexPath)
        case ProductDetailCellIndex.similar:
            return self.setupSimilarCell(tableView, for: indexPath)
        default:
            return self.getAttributeCell(indexPath)
        }
    }
}

// MARK: Setup Table Cell
extension ProductController {
    private func setupImagePriceCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: ProductImagePriceCell.self, for: indexPath)
        cell.configure()
        return cell
    }
    
    private func setupStatusCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: StaticStatusProductCell.self, for: indexPath)
        cell.configure()
        return cell
    }
    
    private func setupVariantCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: ProductVariantCell.self, for: indexPath)
        return cell
    }
    
    private func setupAttributeHeaderCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: ProductAttributesHeaderCell.self, for: indexPath)
        cell.attributesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                self?.attribute = action
                self?.tableView.reloadData()
            }
            .store(in: &attributeToken)
        return cell
    }
    
    private func setupSupplierCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: ProductSupplierCell.self, for: indexPath)
        return cell
    }
    
    private func setupReviewHeaderCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: ProductReviewCell.self, for: indexPath)
        return cell
    }
    
    private func setupReviewDetailCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: ProductReviewDetailCell.self, for: indexPath)
        if indexPath.item == 7 {
            cell.configureFirstReview()
        }
        return cell
    }
    
    private func setupSimilarCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: SimilarProductCell.self, for: indexPath)
        return cell
    }
    
    private func getAttributeCell(_ indexPath: IndexPath) -> UITableViewCell {
        switch attribute {
        case .description:
            let cell = tableView.dequeueReusableCell(withCell: ProductAttributesDescriptionCell.self, for: indexPath)
            cell.configure(with: self.viewModel.dummyDescription)
            return cell
        case .detail:
            let cell = tableView.dequeueReusableCell(withCell: ProductAttributesDetailCell.self, for: indexPath)
            return cell
        case .delivary:
            let cell = tableView.dequeueReusableCell(withCell: ProductAttributesDeliveryCell.self, for: indexPath)
            return cell
        }
    }
}
