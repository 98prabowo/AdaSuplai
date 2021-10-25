//
//  TabBarController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 05/10/21.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupTabBarItem()
    }
    
    private func setupTabBarItem() {
        self.tabBar.tintColor = .primaryGreen
        self.tabBar.barTintColor = .systemBackground
        self.tabBar.backgroundColor = .systemBackground
        if let tabItems = self.tabBar.items {
            tabItems[0].title = "Home"
            tabItems[0].image = UIImage(systemName: "takeoutbag.and.cup.and.straw.fill")
            tabItems[1].title = "Wishlist"
            tabItems[1].image = UIImage(systemName: "heart.fill")
            tabItems[1].isEnabled = false
            tabItems[2].title = "Keranjang"
            tabItems[2].image = UIImage(systemName: "cart.fill")
            tabItems[3].title = "Profile"
            tabItems[3].image = UIImage(systemName: "person.fill")
        }
    }
}
