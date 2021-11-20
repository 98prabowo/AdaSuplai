//
//  DashedSeparatorCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 15/11/21.
//

import UIKit

class DashedSeparatorCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.createDottedLine()
    }
    
    func createDottedLine() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.inactive.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 7]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 16, y: 0),
                                CGPoint(x: UIScreen.main.bounds.maxX - 16, y: 0)])
        
        shapeLayer.path = path
        
        layer.addSublayer(shapeLayer)
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
