//
//  CategoryViewController.swift
//  adaSuplaiTrain
//
//  Created by Felicia Devina on 06/10/21.
//

import UIKit

class CategoryController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table : UITableView!
    var categoryTitle : String = ""
    
    static let identifier = "CategoryController"
    static func nib() -> UINib {
        return UINib(nibName: "CategoryController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpTable()
    }
    
    // MARK: - Navigation Bar
    
    private func setUpNavigationBar(){
        title = categoryTitle
        
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: .some(#selector(searchTapped(_:))))
        navigationItem.hidesBackButton = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItems = [searchButton]
        self.navigationController?.navigationBar.tintColor = .systemGreen
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        //Why you no work
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc func searchTapped(_ sender: UIBarButtonItem) {
        print("Search Tapped")
        
        
        let nextVC = SearchUpdaterController(nibName: SearchUpdaterController.identifier, bundle: nil)
        let navController = UINavigationController(rootViewController: nextVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: false, completion: nil)
    }
    
    // MARK: - Table
    
    private func setUpTable(){
        table.register(PromoProductCell.nib(), forCellReuseIdentifier: PromoProductCell.identifier)
        table.register(AllProductCell.nib(), forCellReuseIdentifier: AllProductCell.identifier)
        table.dataSource = self
        table.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: PromoProductCell.identifier, for: indexPath) as! PromoProductCell
            cell.backgroundColor = .systemGray6
            return cell
            
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: PromoProductCell.identifier, for: indexPath) as! PromoProductCell
            //UIColor(rgb: 0xFAFCFE)
            cell.backgroundColor = .systemGray6
            return cell
            
        case 2 :
            let cell = tableView.dequeueReusableCell(withIdentifier: AllProductCell.identifier, for: indexPath) as! AllProductCell
            cell.backgroundColor = .systemGray6
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
