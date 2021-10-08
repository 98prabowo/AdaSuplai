//
//  AllCategoriesController.swift
//  adaSuplaiTrain
//
//  Created by Felicia Devina on 07/10/21.
//

import UIKit

class AllCategoriesController: UIViewController, Identifiable, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpCollectionView()
    }
    
    // MARK: - Navigation Bar
    
    private func setUpNavigationBar(){
        title = "Lihat Lebih"
        
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: .some(#selector(searchTapped(_:))))
        navigationItem.hidesBackButton = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItems = [searchButton]
        self.navigationController?.navigationBar.tintColor = .systemGreen
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc func searchTapped(_ sender: UIBarButtonItem) {
        print("Search Tapped")
        
        let nextVC = SearchUpdaterController(nibName: SearchUpdaterController.identifier, bundle: nil)
        let navController = UINavigationController(rootViewController: nextVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: false, completion: nil)
        
    }
    
    // MARK: - Collection View
    
    func setUpCollectionView(){
        collectionView.register(AllCategoryCollectionCell.nib(), forCellWithReuseIdentifier: AllCategoryCollectionCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.backgroundColor = .systemGray6
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllCategoryCollectionCell.identifier, for: indexPath) as! AllCategoryCollectionCell
        cell.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numRowItems:CGFloat = 2
        let padding:CGFloat = 16
        let spacing:CGFloat = 8
        let width = (collectionView.bounds.width / numRowItems) - padding - spacing
        return CGSize(width: width, height: 100)
    }
    
    // MARK: - END
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
