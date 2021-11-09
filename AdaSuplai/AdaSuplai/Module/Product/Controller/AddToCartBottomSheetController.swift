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
    
    let publisher = PassthroughSubject<Void, Never>()
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
        self.setupBackground()
        self.setupButton()
        self.setupProductInfo(with: self.viewModel.product)
    }
    
    private func setupBackground() {
        self.productImage.layer.cornerRadius = 10
        self.productImage.backgroundColor = .secondarySystemFill
    }
    
    private func setupButton() {
        self.addToCartButton.layer.cornerRadius = 10
        self.addToCartButton.backgroundColor = .primaryGreen
        self.addToCartButton.setTitleColor(.systemBackground, for: .normal)
        self.addToCartButton.setTitle(Constant.addToCartButton, for: .normal)
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
        let processor = DownsamplingImageProcessor(size: productImage.bounds.size)
        productImage.kf.indicatorType = .activity
        productImage.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
    @IBAction func addToCartTapped(_ sender: UIButton) {
        self.dismiss(animated: false) { [unowned self] in
            self.publisher.send()
        }
    }
}
