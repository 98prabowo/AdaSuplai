//
//  CategoryViewController.swift
//  adaSuplaiTrain
//
//  Created by Felicia Devina on 06/10/21.
//

import UIKit
import Combine

class CategoryController: BaseUIViewController {
    
    @IBOutlet var table: UITableView!
    private var  subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpTable()
    }
    
    private func configure(title: String) {
        self.title = title
    }
    
    // MARK: - Navigation Bar
    private func setUpNavigationBar() {
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .white
        navigation.navigationBar.barTintColor = .white
        navigation.navigationBar.tintColor = .primaryGreen
        self.view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        self.addBackButton()
        self.addSearchButton(tintColor: .primaryGreen)
    }
    
    // MARK: - Navigate
    private func goToProductController() {
        // TODO: create product data then input to ProductController
//        let nextVC = ProductController()
//        if let navigationController = self.navigationController {
//            navigationController.pushViewController(nextVC, animated: true)
//        }
        print("Test Product")
    }
}

// MARK: - Table
extension CategoryController: UITableViewDelegate, UITableViewDataSource {
    private func setUpTable() {
        table.register(PromoProductCell.nib(), forCellReuseIdentifier: PromoProductCell.identifier)
        table.register(AllProductCell.nib(), forCellReuseIdentifier: AllProductCell.identifier)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .blueBackground
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withCell: PromoProductCell.self, for: indexPath)
            cell.promoProductPublisher
                .sink { [unowned self] in
                    self.goToProductController()
                }
                .store(in: &subscribers)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withCell: PromoProductCell.self, for: indexPath)
            cell.promoProductPublisher
                .sink { [unowned self] in
                    self.goToProductController()
                }
                .store(in: &subscribers)
            return cell
            
        case 2 :
            let cell = tableView.dequeueReusableCell(withCell: AllProductCell.self, for: indexPath)
            cell.allProductPublisher
                .sink { [unowned self] in
                self.goToProductController()
            }
            .store(in: &subscribers)
            return cell
            
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}
// MARK: - END
