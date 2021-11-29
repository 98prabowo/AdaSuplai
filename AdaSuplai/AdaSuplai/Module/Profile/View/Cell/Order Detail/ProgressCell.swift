//
//  ProgressCell.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 15/11/21.
//

import UIKit

class ProgressCell: UITableViewCell {

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var firstCircleView: UIView!
    @IBOutlet weak var secondCircleView: UIView!
    @IBOutlet weak var thirdCircleView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
//        firstCircleView.addBorderAndCornerRadius(withBorderWidth: 2, borderColor: .white, cornerRadius: 8)
        
        // Selected
        thirdCircleView.backgroundColor = .primaryGreen
        thirdCircleView.layer.borderWidth = 2.0
        thirdCircleView.layer.borderColor = UIColor.primaryGreen.cgColor
        thirdCircleView.layer.cornerRadius = thirdCircleView.frame.width / 2

        let borderLayer = CALayer()
        borderLayer.frame = thirdCircleView.bounds
        borderLayer.borderColor = UIColor.white.cgColor
        borderLayer.borderWidth = 4.0
        borderLayer.cornerRadius = borderLayer.frame.width / 2
        thirdCircleView.layer.insertSublayer(borderLayer, above: thirdCircleView.layer)
        
        // Not Selected
        secondCircleView.layer.cornerRadius = 8
        secondCircleView.backgroundColor = .primaryGreen
        firstCircleView.layer.cornerRadius = 8
        firstCircleView.backgroundColor = .primaryGreen
        lineView.backgroundColor = .primaryGreen
    }
    
    func createDottedLine() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.primaryGreen.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [3, 3]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: stackView.frame.minX, y: firstCircleView.frame.midY),
                                CGPoint(x: stackView.frame.maxX, y: firstCircleView.frame.midY)])
        
        shapeLayer.path = path
//
        lineView.layer.addSublayer(shapeLayer)
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
