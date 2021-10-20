//
//  TransactionDetailController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 12/10/21.
//

import UIKit

class TransactionDetailController: UIViewController, Identifiable, UIGestureRecognizerDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var subTotalLabel: UILabel!
    @IBOutlet var deliveryTotalLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var viewer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        
        title = "Pengiriman"
        
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .white
        navigation.navigationBar.barTintColor = .white
        navigation.navigationBar.tintColor = .primaryGreen
        self.view.backgroundColor = .white
        navigationItem.hidesBackButton = false
        navigation.setNavigationBarHidden(false, animated: false)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: .some(#selector(clickView(_:))))
        tapGesture.delegate = self
        viewer.addGestureRecognizer(tapGesture)

    }
    
    @objc func clickView(_ sender: UIView) {
        print("ViewClick")
    }
    
    private func setUpTable() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerNib(forCell: TextCell.self)
        tableView.registerNib(forCell: InformationCell.self)
        tableView.registerNib(forCell: ShopTransactionDetailCell.self)
        tableView.registerNib(forCell: AllProductTransactionCell.self)
        tableView.registerNib(forCell: ShopTransactionPriceCell.self)
    }
}

extension TransactionDetailController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return 2
            
        default :
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            switch indexPath.row {
            case 0 :
                let cell = tableView.dequeueReusableCell(withCell: TextCell.self, for: indexPath)
                cell.backgroundColor = UIColor.white
                cell.title.text = "Alamat Pengiriman"
                cell.title.font = UIFont.boldSystemFont(ofSize: 17.0)
                cell.cellImage.isHidden = true
                cell.separatorInset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
                cell.selectionStyle = .none
                return cell
                
            case 1 :
                let cell = tableView.dequeueReusableCell(withCell: InformationCell.self, for: indexPath)
                cell.backgroundColor = .white
                cell.title.text = "Cabang Barat"
                cell.desc.font = UIFont.systemFont(ofSize: 13)
                cell.title.textColor = .systemGreen
                
                cell.desc.text = "Theresa | 081234564888 \nJl. Sulawesi No. 21 , Surabaya"
                cell.desc.textColor = .systemGray3
                cell.desc.font = UIFont.systemFont(ofSize: 13)
                return cell
                
            default : return UITableViewCell()
            }
            
        default :
            switch indexPath.row {
            case 0 :
                let cell = tableView.dequeueReusableCell(withCell: ShopTransactionDetailCell.self, for: indexPath)
                return cell
                
            case 1 :
                let cell = tableView.dequeueReusableCell(withCell: AllProductTransactionCell.self, for: indexPath)
                cell.mainTableView = tableView
                if indexPath.section == tableView.numberOfSections-1 {
                    cell.isLast = true
                }
                return cell
                
            case 2 :
                let cell = tableView.dequeueReusableCell(withCell: ShopTransactionPriceCell.self, for: indexPath)
                return cell
                
            default :
                return UITableViewCell()
            }
        }
    }
}
