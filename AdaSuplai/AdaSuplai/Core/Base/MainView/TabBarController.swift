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
        self.tabBar.barTintColor = .systemBackground
        if let tabItems = self.tabBar.items {
            tabItems[0].title = "Home"
            tabItems[0].image = UIImage(systemName: "house.fill")
            tabItems[1].title = "Test"
            tabItems[1].image = UIImage(systemName: "pencil")
        }
    }
}
