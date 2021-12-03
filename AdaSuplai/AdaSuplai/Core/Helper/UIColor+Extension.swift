//
//  Extension-Color.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 07/10/21.
//

import Foundation
import UIKit

extension UIColor {
    /// Convenience initializer for `UIColor`.
    ///
    /// - Parameters:
    ///   - hex: A `String` that indicated color code in hexadecimal.
    ///   - alpha: Opacity or transparency for a color.
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexString: String = (hex as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString as String)
        
        if hexString.hasPrefix("#") {
            scanner.currentIndex = scanner.string.index(after: scanner.currentIndex)
        }
        
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// Convenience initializer for `UIColor`.
    ///
    /// - Parameters:
    ///   - red: An `Int` that indicated magnitude of red color in decimal. The value ranges from 0 to 255.
    ///   - green: An `Int` that indicated magnitude of green color value in decimal. The value ranges from 0 to 255.
    ///   - blue: An `Int` that indicated magnitude of blue color value in decimal. The value ranges from 0 to 255.
    ///   - alpha: Opacity or transparency for a color.
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    /// Convenience initializer for `UIColor`.
    ///
    /// - Parameters:
    ///   - hex: A n`Int` that indicated color code in hexadecimal.
    ///   - alpha: Opacity or transparency for a color.
    public convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(red: (hex >> 16) & 0xff, green: (hex >> 8) & 0xff, blue: hex & 0xff, alpha: alpha)
    }
    
    /// A method to produce `UIColor` based on the magnitudes of color component (red, green, blue, and opacity),
    ///
    /// - Parameters:
    ///   - red: An `Int` that indicated magnitude of red color in decimal. The value ranges from 0 to 255.
    ///   - green: An `Int` that indicated magnitude of green color value in decimal. The value ranges from 0 to 255.
    ///   - blue: An `Int` that indicated magnitude of blue color value in decimal. The value ranges from 0 to 255.
    ///   - alpha: Opacity or transparency for a color.
    public static func color(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat) -> UIColor {
        UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    /// AdaSuplai primary green color
    public static var primaryGreen: UIColor {
        UIColor(hex: "05850B")
    }
    
    /// AdaSuplai pressed green color
    public static var pressedGreen: UIColor {
        UIColor(hex: "1B7316")
    }
    
    /// AdaSuplai text color
    public static var text: UIColor {
        UIColor(hex: "101010")
    }
    
    /// AdaSuplai alert color
    public static var alert: UIColor {
        UIColor(hex: "D53D34")
    }
    
    /// AdaSuplai inactive color
    public static var inactive: UIColor {
        UIColor(hex: "747474")
    }
    
    /// AdaSuplai star color
    public static var star: UIColor {
        UIColor(hex: "FFC700")
    }
    
    /// AdaSuplai blue backgriound color
    public static var blueBackground: UIColor {
        UIColor(hex: "FAFCFE")
    }
    
    /// AdaSuplai greenish color
    public static var discountBackgroundColor: UIColor {
        UIColor(hex: "05850B", alpha: 0.13)
    }
    
    /// AdaSuplai alert background color
    public static var alertBackground: UIColor {
        UIColor(hex: "F9E2E1")
    }
    
}
