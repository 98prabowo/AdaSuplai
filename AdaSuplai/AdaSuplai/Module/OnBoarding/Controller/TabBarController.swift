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
            tabItems[TabBarOrder.home].title = "Home"
            tabItems[TabBarOrder.home].image = UIImage(systemName: "takeoutbag.and.cup.and.straw.fill")
            tabItems[TabBarOrder.wishlist].title = "Favorite"
            tabItems[TabBarOrder.wishlist].image = UIImage(systemName: "heart.fill")
            tabItems[TabBarOrder.cart].title = "Keranjang"
            tabItems[TabBarOrder.cart].image = UIImage(systemName: "cart.fill")
            tabItems[TabBarOrder.profile].title = "Profile"
            tabItems[TabBarOrder.profile].image = UIImage(systemName: "person.fill")
        }
    }
}
