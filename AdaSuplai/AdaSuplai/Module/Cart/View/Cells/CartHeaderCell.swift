//
//  CartHeaderCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 19/10/21.
//

import UIKit
import Combine

class CartHeaderCell: UITableViewCell {
    @IBOutlet private weak var checkmark: UIButton!
    @IBOutlet private weak var checkAllLabel: UILabel!
    @IBOutlet private weak var deleteButton: UIButton!
    
    weak var delegate: CartCellDelegate?
    
    private var checkLabel = "Pilih Semua" {
        didSet {
            DispatchQueue.main.async {
                self.checkAllLabel.text = self.checkLabel
            }
        }
    }
    
    private var deleteLabel = "Hapus" {
        didSet {
            DispatchQueue.main.async {
                self.deleteButton.setTitle(self.deleteLabel, for: .normal)
            }
        }
    }
    
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
        self.setupButton()
    }
    
    private func setupButton() {
        self.checkAllLabel.text = self.checkLabel
        self.checkmark.tintColor = .primaryGreen
        self.deleteButton.setTitleColor(.alert, for: .normal)
        self.deleteButton.setTitle(self.deleteLabel, for: .normal)
    }
    
    func configure(checkLabel: String, deleteLabel: String) {
        self.checkLabel = checkLabel
        self.deleteButton.setTitle(deleteLabel, for: .normal)
    }
    
    func checkmarkHeader() {
        self.isMarked = true
    }
    
    func unCheckmarkHeader() {
        self.isMarked = false
    }
    
    @IBAction func checkmarkTapped(_ sender: UIButton) {
        self.isMarked = !self.isMarked
        guard let delegate = self.delegate else { return }
        delegate.cartHeaderAction(actions: .select(state: isMarked))
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        guard let delegate = self.delegate else { return }
        delegate.cartHeaderAction(actions: .delete)
    }
}

enum CartHeaderCellAction {
    case select(state: Bool)
    case delete
}
