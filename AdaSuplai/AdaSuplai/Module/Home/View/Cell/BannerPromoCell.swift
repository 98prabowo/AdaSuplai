//
//  BannerPromoCell.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import UIKit
import Combine

class BannerPromoCell: UITableViewCell {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var bannerPublisher: PassthroughSubject<Void, Never>?
    
    private let dummyColors: [UIColor] = [.systemRed, .systemCyan, .systemPink]
    private var timer = Timer()
    private var counter: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollectionView()
        self.setupSlideTimer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.bannerPublisher = PassthroughSubject<Void, Never>()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerNib(forCell: BannerCollectionCell.self)
    }
    
    private func setupSlideTimer() {
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeBanner), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func changeBanner() {
        if counter < dummyColors.count {
            let indexPath = IndexPath(item: counter, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.counter += 1
        } else {
            counter = 0
            let indexPath = IndexPath(item: counter, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension BannerPromoCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withCell: BannerCollectionCell.self, for: indexPath)
        cell.configure(color: self.dummyColors[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = collectionView.frame.height
        let width: CGFloat = collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let publisher = self.bannerPublisher else { return }
        publisher.send()
    }
}
