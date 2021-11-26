//
//  AllProductCell.swift
//  adaSuplaiTrain2
//
//  Created by Felicia Devina on 05/10/21.
//

import UIKit
import Combine

class AllProductCell: UITableViewCell {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var mainTableView: UITableView!
    @IBOutlet var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyViewLabel: UILabel!
    private var categoryVM = CategoryViewModel()
    private var categoryName = ""
    
    let allProductPublisher = PassthroughSubject<Product?, Never>()
    
    override func awakeFromNib() {
        setUpCollectionView()
        super.awakeFromNib()
        
        self.categoryVM.categoryProduct.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.setupView()
                self?.setUpCollectionView()
                self?.allProductPublisher.send(nil)
            }
        }
    }
    
    func configure(idCategory: String, name: String) {
        self.categoryName = name
        self.categoryVM.fetchCategoryProduct(id: idCategory) { result in
            if result == false {
                DispatchQueue.main.async {
                    self.setupView()
                }
            }
        }
    }
    
    private func setupView() {
        emptyView.isHidden = categoryVM.categoryProduct.value?.count ?? 0 < 1 ? false : true
        emptyViewLabel.text = "\(categoryName) saat ini tidak tersedia"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
// MARK: - Collection View
extension AllProductCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setUpCollectionView() {
        collectionView.backgroundColor = .blueBackground
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let heightTemp = ceil(CGFloat(collectionView.numberOfItems(inSection: 0))/2) * 305
        let spacingTemp =  ceil(CGFloat(collectionView.numberOfItems(inSection: 0))/2) * 16
        collectionViewHeight.constant = CGFloat(heightTemp+spacingTemp)
        
        self.collectionView.registerNib(forCell: ProductCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryVM.categoryProduct.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: ProductCell.self, for: indexPath)
        if let product = categoryVM.categoryProduct.value?[indexPath.row] {
            cell.configure(product: product)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numRowItems: CGFloat = 2
        let padding: CGFloat = 16
        let spacing: CGFloat = 4
        let width = (collectionView.bounds.width / numRowItems) - padding - spacing
        return CGSize(width: width, height: 305)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let product = self.categoryVM.categoryProduct.value?[indexPath.row] {
            allProductPublisher.send(product)
        }
    }
    
}

// MARK: - END
