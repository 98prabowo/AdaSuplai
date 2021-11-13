//
//  CartSupplierCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 21/10/21.
//

import UIKit
import Combine

class CartSupplierCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var checkmark: UIButton!
    @IBOutlet private weak var supplierName: UILabel!
    @IBOutlet private weak var reorderButton: UIButton!
    
    private var isMarked: Bool = false {
        didSet {
            if isMarked {
                self.checkmark.setImage(UIImage(systemName: "square.fill"), for: .normal)
            } else {
                self.checkmark.setImage(UIImage(systemName: "square"), for: .normal)
            }
        }
    }
    
    weak var delegate: CartCellDelegate?
    private var supplier: SupplierCart?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBackground()
        self.setupButton()
    }
    
    private func setupBackground() {
        self.containerView.addShadow()
    }
    
    private func setupButton() {
        self.checkmark.tintColor = .primaryGreen
        self.reorderButton.tintColor = .primaryGreen
    }
    
    func configure(with supplier: SupplierCart) {
        self.supplier = supplier
        self.supplierName.text = supplier.name
    }
    
    @IBAction func checkmarkTapped(_ sender: UIButton) {
        self.isMarked = !self.isMarked
        guard let delegate = self.delegate,
              let supplier = self.supplier else { return }
        delegate.cartSupplierAction(actions: .select(supplier: supplier, state: self.isMarked))
    }
    
    func checkmarkSupplier() {
        self.isMarked = true
    }
    
    func unCheckmarkSupplier() {
        self.isMarked = false
    }
    
    @IBAction func reorderButtonTapped(_ sender: UIButton) {
    }
}

enum CartSupplierCellAction {
    case select(supplier: SupplierCart, state: Bool)
}
