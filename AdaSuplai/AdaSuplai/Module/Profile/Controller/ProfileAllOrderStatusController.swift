//
//  ProfileAllOrderStatusController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 31/10/21.
//

import UIKit

class ProfileAllOrderStatusController: BaseUIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var emptyView: UIView!
    @IBOutlet weak var emptyViewLabel: UILabel!
    
    private var titles = ["Dalam Proses", "Pengiriman", "Selesai", "Dibatalkan", "Pengembalian"]
    private var data = [0, 0, 1, 0, 0]
    private var selectedIndex = 0 {
        didSet {
            DispatchQueue.main.async {
                self.emptyViewLabel.text = "Tidak ada pesananan \(self.titles[self.selectedIndex])"
                self.collectionView.reloadData()
                self.tableView.reloadData()
                self.setupView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setUpNavigationBar()
        setupTableView()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        emptyView.backgroundColor = .blueBackground
        emptyView.isHidden = tableView.numberOfRows(inSection: 0) < 1 ? false : true
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        
        collectionView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        collectionView.layer.shadowOpacity = 0.1
        collectionView.layer.shadowRadius = 1
        collectionView.layer.masksToBounds = false
        
        collectionView.registerNib(forCell: StatusOrderCollectionCell.self)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .blueBackground
        
        tableView.registerNib(forCell: OrderSmallCell.self)
    }
    
    private func setupItem(_ cell: StatusOrderCollectionCell, indexPath: IndexPath) {
        if indexPath.item == selectedIndex {
            cell.configureSelected(status: titles[indexPath.row])
        } else {
            cell.configure(status: titles[indexPath.row])
        }
    }
    
    // MARK: - Navigation Bar
    private func setUpNavigationBar() {
        title = "Status Pemesanan"
        
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .clear
        navigation.navigationBar.isHidden = false
        navigation.navigationItem.hidesBackButton = true
        navigation.navigationBar.tintColor = .primaryGreen
        self.addBackButton()
    }
    
    private func goToOrderDetailController(orderId: String) {
        let nextVC = OrderDetailController()
        nextVC.hidesBottomBarWhenPushed = true
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
}

// MARK: - Table
extension ProfileAllOrderStatusController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[selectedIndex]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: OrderSmallCell.self, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.goToOrderDetailController(orderId: "")
    }
}

// MARK: - Collection View
extension ProfileAllOrderStatusController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func deselectStatus() {
        for i in 0..<titles.count {
            let indexPath = IndexPath(item: i, section: 0)
            switch indexPath.item {
            default:
                if let cell = collectionView.cellForItem(at: indexPath) as? StatusOrderCollectionCell {
                    cell.configure(status: titles[indexPath.item])
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: StatusOrderCollectionCell.self, for: indexPath)
        self.setupItem(cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)
        self.deselectStatus()
        self.selectedIndex = indexPath.item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = titles[indexPath.item]
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.sizeToFit()
        return CGSize(width: label.frame.width, height: 55)
    }
}
