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
    @IBOutlet weak var warningLabel: UILabel!
    
    private var AuthVM = AuthenticationViewModel()
    private var userDefault = UserDefaults()
    private var isSuccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupTextField()
        setupKeyboard()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar(isHidden: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setUpNavigationBar(isHidden: false)
    }
    
    private func setUpView() {
        view.backgroundColor = .primaryGreen
        bottomContainerView.backgroundColor = .blueBackground
        forgotPasswordButton.tintColor = .white
        loginButton.tintColor = .primaryGreen
        signupButton.tintColor = .primaryGreen
        warningLabel.textColor = .alert
        warningLabel.text = ""
    }
    
    private func setupKeyboard() {
        self.initializeHideKeyboard()
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
        usernameTextField.placeholder = Constant.usernamePlaceholder
        passwordTextField.placeholder = Constant.passwordPlaceholder
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        stackView.layer.cornerRadius = 8
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
    private func checkIsLogin() {
        if userDefault.bool(forKey: "isLogin") {
            self.tabBarController?.selectedIndex = 0
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Navigation Bar
    private func setUpNavigationBar(isHidden: Bool) {
        navigationController?.navigationBar.isHidden = true
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.isHidden = isHidden
        navigation.navigationItem.hidesBackButton = true
        navigation.navigationBar.tintColor = .white
    }
    
    // MARK: - Action
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        print("Forgot Password")
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        self.warningLabel.text = ""
        if !usernameTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
        AuthVM.loginUser(phone: usernameTextField.text!, password: passwordTextField.text!) { result in
                if result {
                    print("Masuk Profile")
                    self.userDefault.set(true, forKey: "isLogin")
                    
                    DispatchQueue.main.async { () -> Void in
                        self.checkIsLogin()
                    }
                    
                } else {
                    DispatchQueue.main.async { () -> Void in
                        self.warningLabel.text = self.AuthVM.response
                    }
                    print("Failed")
                }
            }
        } else {
            warningLabel.text = "Please fill all field"
        }
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        print("Signup")
        let nextVC = SignUpController()
        nextVC.hidesBottomBarWhenPushed = true
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
}

// MARK: - Textfield
extension AuthenticationController: UITextFieldDelegate {
    private func switchTextField(_ textField: UITextField) {
        switch textField {
        case self.usernameTextField:
            self.passwordTextField.becomeFirstResponder()
        case self.passwordTextField:
            self.passwordTextField.resignFirstResponder()
        default:
            self.usernameTextField.becomeFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchTextField(textField)
        return true
    }
}

// MARK: - Keyboard
extension AuthenticationController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue? {
            let height = (frame?.cgRectValue.height)! - (tabBarController?.tabBar.frame.height)!
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
}
