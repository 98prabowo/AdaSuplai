//
//  Extension-UITableView.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import Foundation
import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell> (withCell: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reusableIdentifier(), for: indexPath) as? T else {
            fatalError("Can't not cast Cell with reusable identfier\(T.reusableIdentifier())")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UIView> () -> T {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.reusableIdentifier()) as? T else {
            fatalError("Can't not cast View with reusable identfier\(T.reusableIdentifier())")
        }
        return cell
    }

    func registerNib<T: UITableViewCell>(forCell: T.Type) {
        self.register(UINib(nibName: T.nibName(), bundle: nil), forCellReuseIdentifier: T.reusableIdentifier())
    }

    func registerNib<T: UIView>(forHeaderFooterView: T.Type) {
        self.register(UINib(nibName: T.nibName(), bundle: nil), forHeaderFooterViewReuseIdentifier: T.reusableIdentifier())
    }
}

extension UIView {
    static func nibName() -> String {
        return String(describing: self)
    }

    static func reusableIdentifier() -> String {
        return String(describing: self)
    }
}
