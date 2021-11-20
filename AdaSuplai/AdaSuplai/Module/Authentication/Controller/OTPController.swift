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
    @IBOutlet weak var warningLabel: UILabel!
    
    let authVM = AuthenticationViewModel()
    var user: Register = Register()
    private var userDefault = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupKeyboard()
        setupButton()
        setupTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configure(user: Register) {
        self.user = user
    }
    
    private func setupView() {
        warningLabel.textColor = .alert
        warningLabel.text = ""
        view.backgroundColor = .primaryGreen
        stackView.backgroundColor = .clear
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
    private func setupButton() {
        resendButton.addBorderAndCornerRadius(withBorderWidth: 1, borderColor: .white, cornerRadius: 5)
    }
    
    private func setupNavigationBar() {
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .clear
        navigation.navigationItem.hidesBackButton = true
        navigation.navigationBar.tintColor = .white
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backNavigation(_:)))
        self.navigationItem.leftBarButtonItems = [backButton]
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
    
    private func backToProfile() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 5], animated: true)
    }
    
    // MARK: - Action
    @IBAction func NextButtonClicked(_ sender: UIButton) {
        print("Next")
        authVM.verifyOTP(phoneNumber: self.user.phoneNumber, otp: self.saveOTP()) { result in
            if result {
                self.userDefault.set(true, forKey: "isLogin")
                DispatchQueue.main.async { () -> Void in
                    self.backToProfile()
                }
            } else {
                DispatchQueue.main.async { () -> Void in
                    self.warningLabel.text = self.authVM.response
                }
            }
        }
    }
    
    @IBAction func resendButtonClicked(_ sender: UIButton) {
        print("Resend")
        authVM.resendOTP(phoneNumber: user.phoneNumber) { result in
            if result {
                DispatchQueue.main.async {
                    
                }
            } else {
                self.warningLabel.text = self.authVM.response
            }
        }
    }
    
    @objc private func backNavigation(_ sender: UIBarButtonItem) {
        guard let navigation = self.navigationController else { return }
        navigation.popViewController(animated: true)
    }
    
    // MARK: - TextField
    @objc func textdidChange(textfield: UITextField) {
        let text = textfield.text
        
        if text?.utf16.count == 1 {
            setupNextTextField(text: text, textfield: textfield)
        } else if text!.isEmpty {
            setupPreviousTextField(text: text, textfield: textfield)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
    }
    
    private func setupPreviousTextField(text: String?, textfield: UITextField) {
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
    
    private func setupNextTextField(text: String?, textfield: UITextField) {
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
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
        if textField.text?.utf16.count == maxLength && !string.isEmpty {
            return false
        }
        return true
    }
    
    private func saveOTP() -> String {
        var otp = ""
        
        otp += textField1.text ?? "0"
        otp += textField2.text ?? "0"
        otp += textField3.text ?? "0"
        otp += textField4.text ?? "0"
        otp += textField5.text ?? "0"
        otp += textField6.text ?? "0"
        
        print("OTPnya adalah \(otp)")
        return otp
    }
    
    // MARK: - Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue? {
            let height = (frame?.cgRectValue.height)!
            
            bottomConstraint.constant = height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = 50
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}
