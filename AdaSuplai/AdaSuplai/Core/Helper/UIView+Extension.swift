//
//  Extension-UIView.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 30/09/21. 
//

import Foundation
import UIKit

extension UIView: Identifiable {
    /// Add border and corner radius for all corners and edges of `UIView`.
    ///
    /// - Parameters:
    ///   - withBorderWidth: Width for border in `CGFloat`.
    ///   - borderColor: Color for border in `UIColor`.
    ///   - cornerRadius: Corner radius for `UIView` in `CGFloat`.
    func addBorderAndCornerRadius(withBorderWidth borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    /// Add shadow for a `UIView`.
    ///
    /// - Parameters:
    ///   - color: Color for the shadow. Default to label color.
    ///   - opacity: Opacity or transparency for the shadow. Default to 0.2.
    ///   - radius: Radius for the shdaow in `CGFloat`. Default to 1.
    func addShadow(color: UIColor = .label, opacity: Float = 0.2, radius: CGFloat = 1) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = radius
    }
    
    /// Round corner radius for for specific corners of `UIView`.
    ///
    /// - Parameters:
    ///   - corners: Add array of specific corners that will be rounded.
    ///   - radius: Magnitude of radius for rounded corners.
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
    
    /// Add border for specific edges of `UIView`.
    ///
    /// - Parameters:
    ///   - edges: Add array of specific edges that will be bordered. Default to all edges.
    ///   - color: Color for border in `UIColor`. Default to label color.
    ///   - width: Width for border in `CGFloat`. Default to 1.
    func addSpecificBorders(_ edges: UIRectEdge = .all, color: UIColor = .label, width: CGFloat = 1.0) {
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
