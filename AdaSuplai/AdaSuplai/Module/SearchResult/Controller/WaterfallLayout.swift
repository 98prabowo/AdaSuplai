//
//  WaterfallLayout.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 12/10/21.
//

import Foundation
import UIKit

protocol WaterfallLayoutDelegate: AnyObject {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat
}

class WaterfallLayout: UICollectionViewLayout {
    weak var delegate: WaterfallLayoutDelegate?
    var numberOfColumn = 1
    var horizontalContentInset: CGFloat = 0
    var verticalContentInset: CGFloat = 0
    
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
          return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.right + insets.left)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard let collectionView = collectionView,
              let delegate = delegate else { return }
        if self.cache.isEmpty {
            let columnWidth = contentWidth / CGFloat(self.numberOfColumn)
            var xOffsets = [CGFloat]()
            for column in 0..<numberOfColumn {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
            var yOffsets = [CGFloat](repeating: 0, count: numberOfColumn)
            
            var column = 0
            for item in 0..<collectionView.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                let height = delegate.collectionView(collectionView: collectionView, heightForItemAtIndexPath: indexPath)
                let frame = CGRect(x: xOffsets[column],
                                   y: yOffsets[column],
                                   width: columnWidth,
                                   height: height)
                let insetFrame = frame.insetBy(dx: horizontalContentInset, dy: verticalContentInset)
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attribute.frame = insetFrame
                cache.append(attribute)
                self.contentHeight = max(self.contentHeight, frame.maxY)
                yOffsets[column] = yOffsets[column] + height
                column = column < (numberOfColumn - 1) ? (column + 1) : 0
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attribute in self.cache {
            if attribute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attribute)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
