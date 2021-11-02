//
//  AuthenticationController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 01/10/21.
//

import UIKit
import SwiftUI

class AuthenticationController: BaseUIViewController {
    
    private enum Constant {
        static let usernamePlaceholder = "Alamat Email / No. Telepon"
        static let passwordPlaceholder = "Kata Sandi"
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewTop: UIStackView!
    @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomContainerView: UIView!
    private var keyboradCount = 0
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeHideKeyboard()
        setUpView()
        setupTextField()
        setupKeyboard()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue? {
            let height = (frame?.cgRectValue.height)! / 1.35
            stackViewTop.spacing = 16
            bottomConstraint.constant = height
            keyboradCount += 1
            
            if scrollView.contentSize.height < 320 && keyboradCount < 2 { containerViewHeight.constant = 100 }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        stackViewTop.spacing = 24
        bottomConstraint.constant = 0
        containerViewHeight.constant = 0
        keyboradCount = 0
    }
    
    private func setUpView() {
        view.backgroundColor = .primaryGreen
        bottomContainerView.backgroundColor = .blueBackground
        forgotPasswordButton.tintColor = .white
        loginButton.tintColor = .primaryGreen
        signupButton.tintColor = .primaryGreen
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupTextField() {
        usernameTextField.placeholder = Constant.usernamePlaceholder
        passwordTextField.placeholder = Constant.passwordPlaceholder
        stackView.layer.cornerRadius = 8
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        print("Forgot Password")
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        if !usernameTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
            print("Login")
        }
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        print("Signup")
        let nextVC = SignUpController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
}
