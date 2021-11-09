//
//  SearchUpdaterLastSeenCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 06/10/21.
//

import UIKit

class SearchHistoryHeaderCell: UITableViewCell {
    @IBOutlet private weak var header: UILabel!
    
    var deleteAllHistory: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(header: String) {
        self.header.text = header
    }
    
    @IBAction func deleteAllHistoryTapped(_ sender: Any) {
        self.deleteAllHistory?()
    }
}
