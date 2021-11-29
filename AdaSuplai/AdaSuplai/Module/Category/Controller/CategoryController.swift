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
    private var categoryId: String = ""
    private var  subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpTable()
    }
    
    func configure(category: Category) {
        self.categoryId = category.id
        self.title = category.name
        print("\(self.categoryId) namanya \(category.name)")
    }
    
    func configureHome(category: HomeCategory) {
        self.title = category.category
        self.categoryId = category.id
        
        print("\(category.id) namanya \(category.category)")
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
    private func goToProductController(product: Product) {
        let nextVC = ProductController(product: product)
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
    
    private func reloadAllData() {
        subscribers.removeAll()
        table.reloadData()
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withCell: PromoProductCell.self, for: indexPath)
//            cell.promoProductPublisher
//                .sink { [unowned self] in
//                    self.goToProductController(product: "promo 1\(indexPath.row)")
//                }
//                .store(in: &subscribers)
//            return cell
//
//        case 1:
//            let cell = tableView.dequeueReusableCell(withCell: PromoProductCell.self, for: indexPath)
//            cell.promoProductPublisher
//                .sink { [unowned self] in
//                    self.goToProductController(product: "promo 2\(indexPath.row)")
//                }
//                .store(in: &subscribers)
//            return cell
            
        case 0 :
            let cell = tableView.dequeueReusableCell(withCell: AllProductCell.self, for: indexPath)
            cell.configure(idCategory: categoryId, name: self.title ?? "Produk")
            cell.mainTableView = tableView
            cell.allProductPublisher
                .sink { [ unowned self ] product in
                    if product == nil {
                        self.reloadAllData()
                    } else {
                        self.goToProductController(product: product!)
                    }
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
