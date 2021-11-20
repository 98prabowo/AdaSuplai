//
//  SignUpController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 25/10/21.
//

import UIKit

class SignUpController: BaseUIViewController {
    
    private enum Constant {
        static let emailPlaceholder = "Alamat Email"
        static let phonePlaceholder = "No. Telepon"
        static let passwordPlaceholder = "Kata Sandi"
        static let confirmPasswordPlaceholder = "Konfirmasi Kata Sandi"
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var user: Register = Register()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeHideKeyboard()
        setUpView()
        setUpTextField()
        setupNavigationBar()
        setupKeyboard()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setUpView() {
        setUpTextField()
        setupNavigationBar()
        warningLabel.text = ""
        warningLabel.textColor = .alert
        view.backgroundColor = .primaryGreen
    }
    
    private func setupNavigationBar() {
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .clear
        navigation.navigationItem.hidesBackButton = true
        navigation.navigationBar.tintColor = .white
        self.addBackButton()
    }
    
    private func setUpTextField() {
        emailTextField.placeholder = Constant.emailPlaceholder
        phoneTextField.placeholder = Constant.phonePlaceholder
        passwordTextField.placeholder = Constant.passwordPlaceholder
        confirmPasswordTextField.placeholder = Constant.confirmPasswordPlaceholder
        
        emailTextField.delegate = self
        phoneTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        stackView.layer.cornerRadius = 8
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
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
    
    // MARK: - Action
    @IBAction func signupButtonClicked(_ sender: UIButton) {
        self.warningLabel.text = ""
        if saveUser() {
            let nextVC = AccountInformationController()
            nextVC.configure(user: self.user)
            if let navigationController = self.navigationController {
                navigationController.pushViewController(nextVC, animated: true)
            }
        }
    }
}

// MARK: - Textfield
extension SignUpController: UITextFieldDelegate {
    private func switchTextField(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            self.phoneTextField.becomeFirstResponder()
        case self.phoneTextField:
            self.passwordTextField.becomeFirstResponder()
        case self.passwordTextField:
            self.confirmPasswordTextField.becomeFirstResponder()
        default:
            self.confirmPasswordTextField.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchTextField(textField)
        return true
    }
    
    private func saveUser() -> Bool {
        if checkTextField() {
            if checkPassword() {
                self.user.email =  emailTextField.text ?? ""
                self.user.phoneNumber = phoneTextField.text ?? ""
                self.user.password = passwordTextField.text ?? ""
                return true
            } else {
                self.warningLabel.text = "Please Check your Password"
                return false
            }
        } else {
            self.warningLabel.text = "Fill all the textfield"
            return false
        }
    }
    
    private func checkTextField() -> Bool {
        if (emailTextField.text?.isEmpty)! {
            return false
        } else if (phoneTextField.text?.isEmpty)! {
            return false
        } else if (passwordTextField.text?.isEmpty)! {
            return false
        } else if (confirmPasswordTextField.text?.isEmpty)! {
            return false
        }
        return true
    }
    
    private func checkPassword() -> Bool {
        if passwordTextField.text != confirmPasswordTextField.text {
            return false
        }
        return true
    }
}

// MARK: - Keyboard
extension SignUpController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue? {
            let height = (frame?.cgRectValue.height)! / 1
            stackViewBottomConstraint.constant = 16
            bottomConstraint.constant = height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        stackViewBottomConstraint.constant = 80
        bottomConstraint.constant = 100
    }
}
