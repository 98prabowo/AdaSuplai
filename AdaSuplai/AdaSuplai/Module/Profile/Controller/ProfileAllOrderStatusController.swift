//
//  ProfileAllOrderStatusController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 31/10/21.
//

import UIKit

class ProfileAllOrderStatusController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var emptyView: UIView!
    
    private var titles = ["Dalam Proses", "Pengiriman", "Selesai", "Dibatalkan", "Pengembalian"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupCollectionView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        emptyView.backgroundColor = .blueBackground
        emptyView.isHidden = true
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
}

// MARK: - Table
extension ProfileAllOrderStatusController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: OrderSmallCell.self, for: indexPath)
        return cell
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
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withCell: StatusOrderCollectionCell.self, for: indexPath)
            cell.configureSelected(status: titles[indexPath.row])
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withCell: StatusOrderCollectionCell.self, for: indexPath)
        cell.configure(status: titles[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.deselectStatus()
        if let cell = collectionView.cellForItem(at: indexPath) as? StatusOrderCollectionCell {
            cell.configureSelected(status: titles[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 55)
    }
}
