//
//  SearchResultController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 06/10/21.
//

import UIKit
import Combine

class SearchResultController: BaseUIViewController {
    private enum Constant {
        static let wishlistButtonImage = "slider.horizontal.3"
        static let loading = "Loading..."
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let isItemsDiscount = [true, false, false, true, true, true, false, true, false, false]
    
    private let viewModel: SearchResultViewModel
    private var subscribers = Set<AnyCancellable>()
    
    init(keyword: String) {
        self.viewModel = SearchResultViewModel(keyword: keyword)
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupCollectionView()
        self.bindToViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        guard let navigation = navigationController else { return }
        navigation.navigationBar.backgroundColor = .systemBackground
        navigation.navigationBar.barTintColor = .systemBackground
        navigation.navigationBar.tintColor = .primaryGreen
        self.addBackButton()
        self.addSearchBar(with: self.setupRightButtonItems(),
                          placeholder: self.viewModel.keyword,
                          barColor: .secondarySystemBackground)
    }
    
    private func setupRightButtonItems() -> [UIBarButtonItem] {
        let wishlistButton = UIBarButtonItem(image: UIImage(systemName: Constant.wishlistButtonImage), style: .plain, target: self, action: .some(#selector(filterTapped(_:))))
        wishlistButton.tintColor = .systemGreen
        return [wishlistButton]
    }
    
    @objc private func filterTapped(_ sender: UIBarButtonItem) {
        let nextVC = FilterController()
        self.present(nextVC, animated: true)
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .secondarySystemBackground
        let layout = WaterfallLayout()
        layout.delegate = self
        layout.numberOfColumn = 2
        layout.horizontalContentInset = 5
        layout.verticalContentInset = 5
        self.collectionView.collectionViewLayout = layout
        self.collectionView.registerNib(forCell: ProductCell.self)
    }
    
    private func bindToViewModel() {
        self.viewModel.products
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                self.collectionView.reloadData()
            }.store(in: &subscribers)
    }
    
    private func goToProduct(with product: Product) {
        let nextVC = ProductController(product: product)
        if let navigation = navigationController {
            navigation.pushViewController(nextVC, animated: true)
        }
    }
}

extension SearchResultController: UICollectionViewDelegate, UICollectionViewDataSource, WaterfallLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.products.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: ProductCell.self, for: indexPath)
        let product = self.viewModel.products.value[indexPath.item]
        cell.configure(product: product, location: "Surabaya")
        if self.isItemsDiscount[indexPath.item] {
            cell.isDiscount(product: product)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)
        let product = self.viewModel.products.value[indexPath.item]
        self.goToProduct(with: product)
    }
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 300
        if self.isItemsDiscount[indexPath.item] {
            height = 320
        }
        return height
    }
}
