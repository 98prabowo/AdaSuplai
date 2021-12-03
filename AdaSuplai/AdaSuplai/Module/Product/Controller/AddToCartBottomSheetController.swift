//
//  AddToCartBottomSheetController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 09/11/21.
//

import UIKit
import Combine
import Kingfisher

class AddToCartBottomSheetController: BaseUIViewController {
    private enum Constant {
        static let addToCartButton = "Tambah ke keranjang"
        static let showCartButton = "Lihat Keranjang"
        static let successAdded = "Produk berhasil ditambahkan"
        static let minOrder = "Min. Pembelian "
    }
    
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var productVariant: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var pricePerUnit: UILabel!
    @IBOutlet private weak var minOrder: UILabel!
    @IBOutlet private weak var addToCartButton: UIButton!
    @IBOutlet private weak var productQuantity: AdaSuplaiStepper!
    @IBOutlet private weak var successLabel: UILabel!
    
    let publisher = PassthroughSubject<AddToChartBottomSheetAction, Never>()
    private let viewModel: AddToCartBottomSheetViewModel
    
    private var isAdded: Bool = false
    
    init(product: Product) {
        self.viewModel = AddToCartBottomSheetViewModel(product: product)
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBackground()
        self.setupButton()
        self.setupProductInfo(with: self.viewModel.product)
    }
    
    private func setupBackground() {
        self.productImage.layer.cornerRadius = 10
        self.productImage.backgroundColor = .secondarySystemFill
        self.successLabel.isHidden = true
    }
    
    private func setupButton() {
        self.addToCartButton.layer.cornerRadius = 10
        self.addToCartButton.backgroundColor = .primaryGreen
        self.addToCartButton.setTitleColor(.systemBackground, for: .normal)
        self.addToCartButton.setTitle(Constant.addToCartButton, for: .normal)
        self.productQuantity.value = Double(self.viewModel.product.minOrder)
        self.productQuantity.minimumValue = Double(self.viewModel.product.minOrder)
    }
    
    private func setupProductInfo(with product: Product) {
        self.productName.text = product.name
        self.price.text = product.price.toIDR
        self.minOrder.text = Constant.minOrder + String(product.minOrder)
        self.minOrder.textColor = .alert
        guard let url = URL(string: RemoteURL.image.rawValue + product.image) else { return }
        self.setupImage(url: url)
    }
    
    private func setupImage(url: URL) {
        let processor = DownsamplingImageProcessor(size: self.productImage.bounds.size)
        self.productImage.kf.indicatorType = .activity
        self.productImage.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
    @IBAction private func addToCartTapped(_ sender: UIButton) {
        if UserDefaults().string(forKey: .userID) == nil {
            self.goToLoginPage()
        } else {
            if isAdded {
                self.goToCartPage()
            } else {
                self.addData()
            }
        }
    }
    
    private func goToLoginPage() {
        self.dismiss(animated: false) { [unowned self] in
            self.publisher.send(.goToLogin)
        }
    }
    
    private func goToCartPage() {
        self.dismiss(animated: false) { [unowned self] in
            self.publisher.send(.goToCart)
        }
    }
    
    private func addData() {
        let product = self.viewModel.product
        let quantity = Int(self.productQuantity.value)
        self.viewModel.addToCartData(product: product,
                                     quantity: quantity)
        
        self.successLabel.isHidden = false
        self.productQuantity.isHidden = true
        self.isAdded = true
        self.addToCartButton.setTitle(Constant.showCartButton,
                                      for: .normal)
    }
}

enum AddToChartBottomSheetAction {
    case keyboaardShow
    case goToLogin
    case goToCart
}
