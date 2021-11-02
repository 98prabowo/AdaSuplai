//
//  SignUpController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 25/10/21.
//

import UIKit

class SignUpController: BaseUIViewController {
    
    private enum Constant {
        static let usernamePlaceholder = "Alamat Email / No. Telepon"
        static let passwordPlaceholder = "Kata Sandi"
        static let confirmPasswordPlaceholder = "Konfirmasi Kata Sandi"
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeHideKeyboard()
        setUpView()
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
    
    private func setUpView() {
        setUpTextField()
        view.backgroundColor = .primaryGreen
    }
    
    private func setUpTextField() {
        usernameTextField.placeholder = Constant.usernamePlaceholder
        passwordTextField.placeholder = Constant.passwordPlaceholder
        confirmPasswordTextField.placeholder = Constant.confirmPasswordPlaceholder
        stackView.layer.cornerRadius = 8
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
    @IBAction func signupButtonClicked(_ sender: UIButton) {
        let nextVC = AccountInformationController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
    
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
