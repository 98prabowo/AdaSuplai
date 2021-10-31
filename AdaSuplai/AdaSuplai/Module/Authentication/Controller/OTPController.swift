//
//  OTPController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 25/10/21.
//

import UIKit

class OTPController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField5: UITextField!
    @IBOutlet weak var textField6: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupView() {
        view.backgroundColor = .primaryGreen
        stackView.backgroundColor = .clear
        stackView.isLayoutMarginsRelativeArrangement = true
        setupButton()
        setupTextField()
    }
    
    private func setupButton() {
        resendButton.addBorderAndCornerRadius(withBorderWidth: 1, borderColor: .white, cornerRadius: 5)
    }
    
    private func setupKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func setupTextField() {
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        textField4.delegate = self
        textField5.delegate = self
        textField6.delegate = self
        
        textField1.layer.cornerRadius = 8
        textField2.layer.cornerRadius = 8
        textField3.layer.cornerRadius = 8
        textField4.layer.cornerRadius = 8
        textField5.layer.cornerRadius = 8
        textField6.layer.cornerRadius = 8
        
        textField1.addTarget(self, action: #selector(self.textdidChange(textfield:)), for: UIControl.Event.editingChanged)
        textField2.addTarget(self, action: #selector(self.textdidChange(textfield:)), for: UIControl.Event.editingChanged)
        textField3.addTarget(self, action: #selector(self.textdidChange(textfield:)), for: UIControl.Event.editingChanged)
        textField4.addTarget(self, action: #selector(self.textdidChange(textfield:)), for: UIControl.Event.editingChanged)
        textField5.addTarget(self, action: #selector(self.textdidChange(textfield:)), for: UIControl.Event.editingChanged)
        textField6.addTarget(self, action: #selector(self.textdidChange(textfield:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textdidChange(textfield: UITextField) {
        let text = textfield.text
        
        if text?.utf16.count == 1 {
            switch textfield {
            case textField1:
                textField2.becomeFirstResponder()
                
            case textField2:
                textField3.becomeFirstResponder()
                
            case textField3:
                textField4.becomeFirstResponder()
                
            case textField4:
                textField5.becomeFirstResponder()
                
            case textField5:
                textField6.becomeFirstResponder()
                
            case textField6:
                print("OTP = \(text!)")
                textField6.resignFirstResponder()
                
            default:
                break
            }
        } else if text!.isEmpty {
            switch textfield {
            case textField6:
                textField5.becomeFirstResponder()
                
            case textField5:
                textField4.becomeFirstResponder()
                
            case textField4:
                textField3.becomeFirstResponder()
                
            case textField3:
                textField2.becomeFirstResponder()
                
            case textField2:
                textField1.becomeFirstResponder()
                
            case textField1:
                textField1.resignFirstResponder()
                
            default:
                break
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
        if textField.text?.utf16.count == maxLength && !string.isEmpty {
            return false
        }
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue? {
            let height = (frame?.cgRectValue.height)!
            
            bottomConstraint.constant = height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = 24
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}
