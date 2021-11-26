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
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var buyButton: UIButton!
    @IBOutlet private weak var addToCart: UIButton!
    
    private var subscribers = Set<AnyCancellable>()
    private var attribute: ProductAttribute = .description
    private let viewModel: ProductViewModel
    
    init(product: Product) {
        self.viewModel = ProductViewModel(product: product)
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
        self.bindToViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
        self.setupBackground()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let tabBarController = self.tabBarController else { return }
        tabBarController.tabBar.isHidden = false
    }
    
    private func setupBackground() {
        guard let tabBarController = self.tabBarController else { return }
        tabBarController.tabBar.isHidden = true
        self.tableView.backgroundColor = .blueBackground
        self.containerView.addShadow()
    }
    
    private func setupNavigationBar() {
        let wishlistButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(wishlistButtonTapped(_:)))
        wishlistButton.tintColor = .primaryGreen
        let cartButton = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(cartButtonTapped(_:)))
        cartButton.tintColor = .primaryGreen
        self.addSearchBar(with: [cartButton, wishlistButton],
                          placeholder: Constant.searchPlaceholder,
                          barColor: .systemGray5)
        self.addBackButton()
        
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .systemBackground
        navigation.navigationBar.barTintColor = .systemBackground
        navigation.navigationBar.tintColor = .primaryGreen
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
    
    private func bindToViewModel() {
        self.viewModel.similarProducts
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                self.subscribers.removeAll()
                self.tableView.reloadData()
            }.store(in: &subscribers)
    }
    
    @objc private func wishlistButtonTapped(_ sender: UIBarButtonItem) {
        print("Go To Wishlist")
    }
    
    @objc private func cartButtonTapped(_ sender: UIBarButtonItem) {
        guard let navigation = self.navigationController,
              let tabBarController = self.tabBarController else { return }
        navigation.popViewController(animated: false)
        tabBarController.selectedIndex = 1
    }
    
    @IBAction private func buyButtonTapped(_ sender: UIButton) {
        // TODO: Add products quantity data
        if let navigation = self.navigationController,
           let cart = self.viewModel.getCartData(product: self.viewModel.product, quantity: 5) {
            let nextVC = TransactionDetailController(source: .productPage(data: cart))
            navigation.pushViewController(nextVC, animated: true)
        }
    }
    
    @IBAction private func addToCartButtonTapped(_ sender: UIButton) {
        let nextVC = AddToCartBottomSheetController(product: self.viewModel.product)
        
        if let sheet = nextVC.presentationController as? UISheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            nextVC.publisher
                .sink { [weak self] value in
                    switch value {
                    case .keyboaardShow:
                        sheet.selectedDetentIdentifier = .large
                    case .goToCart:
                        guard let navigation = self?.navigationController,
                              let tabBarController = self?.tabBarController else { return }
                        navigation.popViewController(animated: false)
                        tabBarController.selectedIndex = 1
                    case .addedToCart:
                        break
                    }
                }.store(in: &subscribers)
        }
        
        self.present(nextVC, animated: true)
    }
    
    private func goToReviewPage() {
        let reviews = self.viewModel.product.reviews
        let nextVC = ReviewController(with: reviews)
        if let navigation = self.navigationController {
            navigation.pushViewController(nextVC, animated: true)
        }
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
        cell.configure(with: self.viewModel.product)
        return cell
    }
    
    private func setupStatusCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: StaticStatusProductCell.self, for: indexPath)
        cell.configure(with: self.viewModel.product)
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
                self?.subscribers.removeAll()
                self?.tableView.reloadData()
            }
            .store(in: &subscribers)
        return cell
    }
    
    private func setupSupplierCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: ProductSupplierCell.self, for: indexPath)
        cell.configure(with: self.viewModel.product.supplier)
        return cell
    }
    
    private func setupReviewHeaderCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: ProductReviewCell.self, for: indexPath)
        cell.configure(with: self.viewModel.product)
        cell.reviewHeaderPublisher
            .sink { [unowned self] in
                self.goToReviewPage()
            }.store(in: &subscribers)
        return cell
    }
    
    private func setupReviewDetailCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: ProductReviewDetailCell.self, for: indexPath)
        if let review = self.viewModel.product.reviews.first {
            cell.configure(with: review)
        }
        return cell
    }
    
    private func setupSimilarCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: SimilarProductCell.self, for: indexPath)
        cell.configure(with: self.viewModel.similarProducts.value)
        if let navigation = self.navigationController {
            cell.publisher
                .sink { product in
                    let nextVC = ProductController(product: product)
                    navigation.pushViewController(nextVC, animated: true)
                }.store(in: &subscribers)
        }
        return cell
    }
    
    private func getAttributeCell(_ indexPath: IndexPath) -> UITableViewCell {
        switch attribute {
        case .description:
            let cell = tableView.dequeueReusableCell(withCell: ProductAttributesDescriptionCell.self, for: indexPath)
            cell.configure(with: self.viewModel.product)
            return cell
        case .detail:
            let cell = tableView.dequeueReusableCell(withCell: ProductAttributesDetailCell.self, for: indexPath)
            cell.configure(with: self.viewModel.product)
            return cell
        case .delivary:
            let cell = tableView.dequeueReusableCell(withCell: ProductAttributesDeliveryCell.self, for: indexPath)
            cell.configure(with: self.viewModel.product)
            return cell
        }
    }
}
