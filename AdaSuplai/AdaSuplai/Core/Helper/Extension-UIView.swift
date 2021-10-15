//
//  Extension-UIView.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 30/09/21. 
//

import Foundation
import UIKit

extension UIView {
    static func nibName() -> String {
        return String(describing: self)
    }

    static func reusableIdentifier() -> String {
        return String(describing: self)
    }
    
    func roundSpecificCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        self.layer.masksToBounds = true
    }
    
    func roundSpecificCornersAndBorder(_ corners: UIRectCorner, radius: CGFloat, borderColor: UIColor = .clear, borderWidth: CGFloat = 0.0) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.masksToBounds = true
    }
    
    func addBorderAndCornerRadius(withBorderWidth borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func addShadow(color: UIColor = .black, opacity: Float = 0.2, radius: CGFloat = 1) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = radius
    }
}
