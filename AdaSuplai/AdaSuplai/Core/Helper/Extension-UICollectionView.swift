//
//  Extension-UICollectionView.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 12/10/21.
//

import Foundation
import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell> (withCell: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier(), for: indexPath) as? T else {
            fatalError("Can't not cast Cell with reusable identfier\(T.reusableIdentifier())")
        }
        return cell
    }

    func registerNib<T: UICollectionViewCell>(forCell: T.Type) {
        self.register(UINib(nibName: T.nibName(), bundle: nil), forCellWithReuseIdentifier: T.reusableIdentifier())
    }
}
