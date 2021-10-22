//
//  CartHeaderCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 19/10/21.
//

import UIKit

class CartHeaderCell: UITableViewCell, Identifiable {
    @IBOutlet private weak var checkMark: UIImageView!
    @IBOutlet private weak var checkAllLabel: UILabel!
    @IBOutlet private weak var deleteButton: UIButton!
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
    }
    
    private func setupButton() {
        self.checkAllLabel.text = self.checkLabel
        self.checkMark.tintColor = .primaryGreen
        self.deleteButton.setTitleColor(.alert, for: .normal)
        self.deleteButton.setTitle(self.deleteLabel, for: .normal)
    }
    
    func configure(checkLabel: String, deleteLabel: String) {
        self.checkLabel = checkLabel
        self.deleteButton.setTitle(deleteLabel, for: .normal)
    }
}
