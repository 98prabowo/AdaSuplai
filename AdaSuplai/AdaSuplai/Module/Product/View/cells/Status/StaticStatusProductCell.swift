//
//  StaticStatusProductCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 28/10/21.
//

import UIKit

class StaticStatusProductCell: UITableViewCell {
    private enum Constant {
        static let sold = "TERJUAL"
        static let stock = "STOK"
        static let quantity = "BERAT"
        static let minOrder = "MIN. PESAN"
    }
    
    @IBOutlet private weak var headerA: UILabel!
    @IBOutlet private weak var statusA: UILabel!
    @IBOutlet private weak var headerB: UILabel!
    @IBOutlet private weak var statusB: UILabel!
    @IBOutlet private weak var headerC: UILabel!
    @IBOutlet private weak var statusC: UILabel!
    @IBOutlet private weak var headerD: UILabel!
    @IBOutlet private weak var statusD: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupHeader()
    }
    
    private func setupHeader() {
        self.headerA.text = Constant.sold
        self.headerB.text = Constant.stock
        self.headerC.text = Constant.quantity
        self.headerD.text = Constant.minOrder
    }
    
    func configure() {
        self.statusA.text = "156"
        self.statusB.text = "500"
        self.statusC.text = "10 ONS"
        self.statusD.text = "120 ONS"
    }
}
