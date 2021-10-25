//
//  AdaSuplaiStepper.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 21/10/21.
//

import Foundation
import UIKit

@IBDesignable public class AdaSuplaiStepper: UIControl {
    /// Current value of stepper.
    private var value: Double = 0 {
        didSet {
            valueLabel.text = String(Int(value))
            self.setLeftButtonColor(enableColor: buttonEnableColor,
                                    disableColor: buttonDisableColor)
            self.setRightButtonColor(enableColor: buttonEnableColor,
                                    disableColor: buttonDisableColor)
        }
    }
    
    /// Disable or enable maximum infinity
    @IBInspectable public var maxInfinity: Bool = false
    
    /// Minimum value of stepper. Default to 1
    @IBInspectable public var minimumValue: Double = 1
    
    /// Maximum value of stepper. Default to 100
    @IBInspectable public var maximumValue: Double = 100
    
    /// Stepper incement value. Default to 1
    @IBInspectable public var increment: Double = 1
    
    /// Background color of the enabled button in stepper. Default primary green
    @IBInspectable public var buttonEnableColor: UIColor = .primaryGreen {
        didSet {
            self.setLeftButtonColor(enableColor: buttonEnableColor,
                                    disableColor: buttonDisableColor)
            self.setRightButtonColor(enableColor: buttonEnableColor,
                                    disableColor: buttonDisableColor)
        }
    }
    
    /// Background color of the disabled button in stepper. Default system gray
    @IBInspectable public var buttonDisableColor: UIColor = .systemGray {
        didSet {
            self.setLeftButtonColor(enableColor: buttonEnableColor,
                                    disableColor: buttonDisableColor)
            self.setRightButtonColor(enableColor: buttonEnableColor,
                                    disableColor: buttonDisableColor)
        }
    }
    
    /// Corner radius of stepper. Default to 10
    @IBInspectable public var cornerRadius: CGFloat = 10 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    /// Border width of stepper. Default to 1
    @IBInspectable public var borderWidth: CGFloat = 1 {
        didSet {
            valueLabel.addSpecificBorders([.top, .bottom],
                                  color: borderColor,
                                  width: borderWidth)
        }
    }
    
    /// Border width of stepper. Default to primary green
    @IBInspectable public var borderColor: UIColor = .primaryGreen {
        didSet {
            valueLabel.addSpecificBorders([.top, .bottom],
                                  color: borderColor,
                                  width: borderWidth)
        }
    }
    
    /// Left button image name. Use SF Symbols name. Default is sf minus
    @IBInspectable public var leftButtonImage: UIImage? = UIImage(systemName: "minus") {
        didSet {
            leftButton.setImage(leftButtonImage, for: .normal)
        }
    }
    
    /// Right button image name. Use SF Symbols name. Default is sf plus
    @IBInspectable public var rightButtonImage: UIImage? = UIImage(systemName: "plus") {
        didSet {
            rightButton.setImage(rightButtonImage, for: .normal)
        }
    }
    
    /// Text color of the label. Default is label
    @IBInspectable public var textColor: UIColor = .label {
        didSet {
            valueLabel.textColor = textColor
        }
    }
    
    /// Number of lines of the label. Default to 1
    @IBInspectable public var numberOfLines: Int = 1 {
        didSet {
            valueLabel.numberOfLines = numberOfLines
        }
    }
    
    /// Font of the label. Default to system with size 17 regular
    public var font: UIFont = UIFont.systemFont(ofSize: 17) {
        didSet {
            valueLabel.font = font
        }
    }
    
    /// The same as UIStepper's autorepeat. If true, holding on the buttons or keeping the pan gesture alters the value repeatedly. Defaults to true.
    @IBInspectable public var autorepeat: Bool = true
    
    private var timer: Timer?
    private var repeatSpeed: Double = 0.2
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemBackground
        button.setImage(leftButtonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(leftButtonDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(leftButtonUp(_:)), for: [.touchUpInside, .touchUpOutside, .touchDragExit])
        return button
    }()

    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemBackground
        button.setImage(rightButtonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(rightButtonDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(rightButtonUp(_:)), for: [.touchUpInside, .touchUpOutside, .touchDragExit])
        return button
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.text = String(Int(value))
        label.textColor = textColor
        label.font = font
        label.layer.masksToBounds = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.addArrangedSubview(leftButton)
        stack.addArrangedSubview(valueLabel)
        stack.addArrangedSubview(rightButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    deinit {
        self.resetTimer()
    }
    
    private func setupView() {
        self.value = self.minimumValue
        self.addSubview(stack)
        self.setupConstraint()
        self.setLeftButtonColor(enableColor: buttonEnableColor,
                                disableColor: buttonDisableColor)
        self.setRightButtonColor(enableColor: buttonEnableColor,
                                disableColor: buttonDisableColor)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        valueLabel.addSpecificBorders([.top, .bottom],
                              color: borderColor,
                              width: borderWidth)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            stack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setRightButtonColor(enableColor: UIColor, disableColor: UIColor) {
        if value == maximumValue {
            rightButton.isEnabled = false
            rightButton.backgroundColor = disableColor
        } else {
            rightButton.isEnabled = true
            rightButton.backgroundColor = enableColor
        }
    }
    
    private func setLeftButtonColor(enableColor: UIColor, disableColor: UIColor) {
        if value == minimumValue {
            leftButton.isEnabled = false
            leftButton.backgroundColor = disableColor
        } else {
            leftButton.isEnabled = true
            leftButton.backgroundColor = enableColor
        }
    }
    
    @objc private func leftButtonAction() {
        if value > minimumValue {
            self.value -= self.increment
        } else if self.timer != nil {
            self.resetTimer()
        }
    }
    
    @objc private func rightButtonAction() {
        if value < maximumValue {
            self.value += self.increment
        } else if maxInfinity {
            self.value += self.increment
        } else if self.timer != nil {
            self.resetTimer()
        }
    }
    
    @objc private func leftButtonDown(_ sender: UIButton) {
        if autorepeat {
            self.leftButtonAction()
            timer = Timer.scheduledTimer(timeInterval: repeatSpeed, target: self, selector: #selector(leftButtonAction), userInfo: nil, repeats: true)
        } else {
            self.leftButtonAction()
        }
    }
    
    @objc private func leftButtonUp(_ sender: UIButton) {
        self.resetTimer()
    }
    
    @objc private func rightButtonDown(_ sender: UIButton) {
        if autorepeat {
            self.rightButtonAction()
            timer = Timer.scheduledTimer(timeInterval: repeatSpeed, target: self, selector: #selector(rightButtonAction), userInfo: nil, repeats: true)
        } else {
            self.rightButtonAction()
        }
    }
    
    @objc private func rightButtonUp(_ sender: UIButton) {
        self.resetTimer()
    }
    
    private func resetTimer() {
        guard let timer = self.timer else { return }
        timer.invalidate()
        self.timer = nil
    }
}
