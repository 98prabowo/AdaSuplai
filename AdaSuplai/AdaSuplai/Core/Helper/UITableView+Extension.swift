//
//  Extension-UITableView.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import Foundation
import UIKit

extension UITableView {
    /// Shorter method caller for registering `UITableViewCell` in `UITableViewController`.
    ///
    /// - Parameters:
    ///   - forCell: A `UITableViewCell` class that need to implement identifier.
    func registerNib<T: UITableViewCell>(forCell: T.Type) {
        self.register(UINib(nibName: T.identifier, bundle: nil), forCellReuseIdentifier: T.identifier)
    }

    /// Shorter method caller for registering `UIView` in `UITableViewController` header and footer.
    ///
    /// - Parameters:
    ///   - forHeaderFooterView: A `UIView` class that need to implement identifier.
    func registerNib<T: UIView>(forHeaderFooterView: T.Type) {
        self.register(UINib(nibName: T.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: T.identifier)
    }
    
    /// Dequeue reusable cell with shorter method caller for `UITableViewCell`. If error when dequeue will return instance of `UITableViewCell`.
    ///
    /// - Parameters:
    ///   - withCell: A `UITableViewCell` class that need to implement identifier.
    ///   - indexPath: An `IndexPath` from cellForRowAt method.
    func dequeueReusableCell<T: UITableViewCell> (withCell: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            return T()
        }
        return cell
    }
    
    /// Dequeue reusable cell with shorter method caller for `UIView` header and footer. If error when dequeue will return instance of `UIView`.
    func dequeueReusableHeaderFooterView<T: UIView> () -> T {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as? T else {
            return T()
        }
        return cell
    }
}
