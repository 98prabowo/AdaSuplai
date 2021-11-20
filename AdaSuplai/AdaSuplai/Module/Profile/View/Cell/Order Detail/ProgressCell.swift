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
        firstCircleView.addBorderAndCornerRadius(withBorderWidth: 2, borderColor: .primaryGreen, cornerRadius: 8)
        firstCircleView.backgroundColor = .white
        secondCircleView.layer.cornerRadius = 8
        thirdCircleView.layer.cornerRadius = 8
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
