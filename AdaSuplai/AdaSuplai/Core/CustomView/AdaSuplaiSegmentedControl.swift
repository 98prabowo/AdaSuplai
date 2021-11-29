//
//  CustomSegmentedControl.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 15/11/21.
//

import Foundation
import UIKit

@IBDesignable class AdaSuplaiSegmentedControl: UIControl {
    private var buttons = [UIButton]()
    private var selectorView: UIView?
    
    /// Segmented control selected index.
    var selectedIndex: Int = 0 
    
    /// Titles of segmented control items.
    public var buttonTitles = ["Segment 1", "Segment 2", "Segment 3"] {
        didSet {
            self.updateView()
        }
    }
    
    /// Segmented control item's title size.
    @IBInspectable public var textSize: CGFloat = 15 {
        didSet {
            self.updateView()
        }
    }
    
    /// Segmented control item's title color.
    @IBInspectable public var textColor: UIColor = .label {
        didSet {
            self.updateView()
        }
    }
    
    /// Segmented control selector's color.
    @IBInspectable public var selectorViewColor: UIColor = .primaryGreen {
        didSet {
            self.updateView()
        }
    }
    
    /// Segmented control selector's text color.
    @IBInspectable public var selectorTextColor: UIColor = .primaryGreen {
        didSet {
            self.updateView()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.updateView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.updateView()
    }
    
    private func updateView() {
        self.subviews.forEach { $0.removeFromSuperview() }
        self.setupButton()
        let stack = self.setupStackView()
        self.setupSelectorView(with: stack)
    }
    
    private func setupSelectorView(with stack: UIStackView) {
        let height = self.frame.height
        if let title = buttonTitles.first {
            let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: self.textSize)]
            let width = (title as NSString).size(withAttributes: fontAttributes).width + 30
            self.selectorView = UIView(frame: CGRect(x: 0,
                                                     y: height,
                                                     width: width,
                                                     height: 2))
        }
        if let selectorView = self.selectorView {
            selectorView.backgroundColor = self.selectorViewColor
            self.addSubview(selectorView)
        }
    }
    
    private func setupStackView() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: self.buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        self.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        return stack
    }
    
    private func setupButton() {
        self.buttons.removeAll()
        for buttonTitle in self.buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            button.setTitleColor(self.textColor, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: self.textSize)
            buttons.append(button)
        }
        let selectedButton = self.buttons[selectedIndex]
        selectedButton.setTitleColor(self.selectorTextColor, for: .normal)
        selectedButton.titleLabel?.font = .boldSystemFont(ofSize: self.textSize)
        self.setSelectorPos(button: selectedButton, pos: 0)
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        for (index, button) in self.buttons.enumerated() {
            button.setTitleColor(self.textColor, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: self.textSize)
            if button == sender {
                let selectorPosition = self.getSelectorPosition(from: index)
                self.selectedIndex = index
                UIView.animate(withDuration: 0.3) {
                    self.setSelectorPos(button: button, pos: selectorPosition)
                }
                button.setTitleColor(selectorTextColor, for: .normal)
                button.titleLabel?.font = .boldSystemFont(ofSize: self.textSize)
            }
        }
        self.sendActions(for: .valueChanged)
    }
    
    private func getSelectorPosition(from index: Int) -> CGFloat {
        var result: CGFloat = 0
        if index > 0 {
            for (btnIndex, button) in buttons.enumerated()
            where btnIndex < index {
                result += button.frame.width
            }
        }
        return result
    }
    
    private func setSelectorPos(button: UIButton, pos: CGFloat) {
        guard let selector = self.selectorView else { return }
        let height = self.frame.height
        let width = button.frame.width
        selector.frame = CGRect(x: pos,
                                y: height,
                                width: width,
                                height: 2)
    }
}
