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
    
    func roundSpecificCorners(_ corners: UIRectCorner, radius: CGFloat) {
        self.layer.cornerRadius = radius
        var masked = CACornerMask()
        
        if corners.contains(.allCorners) || corners.contains(.topLeft) {
            masked.insert(CACornerMask.layerMinXMinYCorner)
        }
        
        if corners.contains(.allCorners) || corners.contains(.topRight) {
            masked.insert(CACornerMask.layerMaxXMinYCorner)
        }
        
        if corners.contains(.allCorners) || corners.contains(.bottomLeft) {
            masked.insert(CACornerMask.layerMinXMaxYCorner)
        }
        
        if corners.contains(.allCorners) || corners.contains(.bottomLeft) {
            masked.insert(CACornerMask.layerMaxXMaxYCorner)
        }
        self.layer.maskedCorners = masked
    }
    
    func addSpecificBorders(_ edges: UIRectEdge = .all, color: UIColor = .black, width: CGFloat = 1.0) {
        func createBorder() -> UIView {
            let borderView = UIView(frame: CGRect.zero)
            borderView.translatesAutoresizingMaskIntoConstraints = false
            borderView.backgroundColor = color
            return borderView
        }
        
        if edges.contains(.all) || edges.contains(.top) {
            let topBorder = createBorder()
            self.addSubview(topBorder)
            NSLayoutConstraint.activate([
                topBorder.topAnchor.constraint(equalTo: self.topAnchor),
                topBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                topBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                topBorder.heightAnchor.constraint(equalToConstant: width)
            ])
        }
        
        if edges.contains(.all) || edges.contains(.left) {
            let leftBorder = createBorder()
            self.addSubview(leftBorder)
            NSLayoutConstraint.activate([
                leftBorder.topAnchor.constraint(equalTo: self.topAnchor),
                leftBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                leftBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                leftBorder.widthAnchor.constraint(equalToConstant: width)
            ])
        }
        
        if edges.contains(.all) || edges.contains(.right) {
            let rightBorder = createBorder()
            self.addSubview(rightBorder)
            NSLayoutConstraint.activate([
                rightBorder.topAnchor.constraint(equalTo: self.topAnchor),
                rightBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                rightBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                rightBorder.widthAnchor.constraint(equalToConstant: width)
            ])
        }
        
        if edges.contains(.all) || edges.contains(.bottom) {
            let bottomBorder = createBorder()
            self.addSubview(bottomBorder)
            NSLayoutConstraint.activate([
                bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                bottomBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                bottomBorder.heightAnchor.constraint(equalToConstant: width)
            ])
        }
    }
}
