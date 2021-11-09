//
//  SearchHistoryCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/11/21.
//

import UIKit

class SearchHistoryCell: UITableViewCell {
    @IBOutlet private weak var historyIcon: UIImageView!
    @IBOutlet private weak var searchHistory: UILabel!
    
    var deleteHistory: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(history: String?, icon: UIImage? = nil) {
        guard let history = history else { return }
        self.searchHistory.text = history
        if let icon = icon {
            self.historyIcon.image = icon
        }
    }
    
    @IBAction func deleteHistory(_ sender: UIButton) {
        self.deleteHistory?()
    }
}
