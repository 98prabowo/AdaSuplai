//
//  Extension-UICollectionView.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 12/10/21.
//

import Foundation
import UIKit

extension UICollectionView {
    /// Shorter method caller for registering `UICollectionViewCell` in `UICollectionViewController`.
    ///
    /// - Parameters:
    ///   - forCell: A `UICollectionViewCell` class that need to implement identifier.
    func registerNib<T: UICollectionViewCell>(forCell: T.Type) {
        self.register(UINib(nibName: T.identifier, bundle: nil), forCellWithReuseIdentifier: T.identifier)
    }
    
    /// Dequeue reusable cell with shorter method caller for `UICollectionViewCell`. If error when dequeue will return instance of `UICollectionViewCell`.
    ///
    /// - Parameters:
    ///   - withCell: A `UICollectionViewCell` class that need to implement identifier.
    ///   - indexPath: An `IndexPath` from cellForItemAt method.
    func dequeueReusableCell<T: UICollectionViewCell> (withCell: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            return T()
        }
        return cell
    }
}
