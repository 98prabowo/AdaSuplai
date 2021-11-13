//
//  CartProductCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 21/10/21.
//

import UIKit
import Combine
import Kingfisher

protocol CartCellDelegate: AnyObject {
    func cartHeaderAction(actions: CartHeaderCellAction)
    func cartSupplierAction(actions: CartSupplierCellAction)
    func cartProductActions(actions: CartProductCellAction)
}

class CartProductCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var checkmark: UIButton!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var productVariant: UILabel!
    @IBOutlet private weak var productPrice: UILabel!
    @IBOutlet private weak var addNoteButton: UIButton!
    @IBOutlet private weak var quantityCounter: AdaSuplaiStepper!
    @IBOutlet private weak var bottomSpace: NSLayoutConstraint!
    
    weak var delegate: CartCellDelegate?
    private var product: ProductCart?
    
    private var isMarked: Bool = false {
        didSet {
            if isMarked {
                self.checkmark.setImage(UIImage(systemName: "square.fill"), for: .normal)
            } else {
                self.checkmark.setImage(UIImage(systemName: "square"), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBackground()
        self.setupButton()
    }
    
    private func setupBackground() {
        self.containerView.addShadow()
        self.productImage.layer.cornerRadius = 10
        self.productImage.backgroundColor = .secondarySystemFill
    }
    
    private func setupButton() {
        self.checkmark.tintColor = .primaryGreen
        self.addNoteButton.setTitleColor(.primaryGreen, for: .normal)
        self.quantityCounter.delegate = self
    }
    
    func configure(with product: ProductCart) {
        self.product = product
        self.productPrice.text = product.productPrice.toIDR
        self.productName.text = product.productName
        self.productVariant.isHidden = true
        self.quantityCounter.value = Double(product.quantity)
        guard let imageID = product.image,
              let url = URL(string: RemoteURL.image.rawValue + imageID) else { return }
        self.setupImage(url: url)
    }
    
    func checkmarkProduct() {
        self.isMarked = true
    }
    
    func unCheckmarkProduct() {
        self.isMarked = false
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
    
    @IBAction func checkmarkTapped(_ sender: UIButton) {
        self.isMarked = !self.isMarked
        guard let delegate = self.delegate,
              let product = self.product else { return }
        delegate.cartProductActions(actions: .select(product: product, state: isMarked))
    }
    
    @IBAction func addNoteButtonTapped(_ sender: UIButton) {
    }
}

extension CartProductCell: AdaSuplaiStepperDelegate {
    func valueDidChange(value: Double) {
        guard let delegate = delegate,
              let product = self.product else { return }
        delegate.cartProductActions(actions: .stepperChange(product: product,
                                                            quantity: Int(value)))
    }
}

enum CartProductCellAction {
    case stepperChange(product: ProductCart, quantity: Int)
    case select(product: ProductCart, state: Bool)
    case addNotes
}
