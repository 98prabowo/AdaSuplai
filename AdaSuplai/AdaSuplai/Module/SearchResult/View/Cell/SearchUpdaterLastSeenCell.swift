//
//  SearchUpdaterLastSeenCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 06/10/21.
//

import UIKit

class SearchUpdaterLastSeenCell: UITableViewCell, Identifiable {
    @IBOutlet private weak var history: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(history: String) {
//        self.history.text = history
    }
    
    @IBAction func deleteAllHistoryTapped(_ sender: Any) {
        print("Delete All")
    }
    
    @IBAction func deleteHistoryTapped(_ sender: Any) {
        print("Delete this item")
    }
}
