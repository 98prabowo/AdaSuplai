//
//  AccountInformationController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 25/10/21.
//

import UIKit

class AccountInformationController: UIViewController {
    
    private enum Constant {
        static let namePlaceholder = "Nama"
        static let birthdatePlaceholder = "Tanggal Lahir"
        static let genderPlaceholder = "Jenis Kelamin"
        static let businessNamePlaceholder = "Nama Bisnis (opsional)"
        static let businessCategoryPlaceholder = "Kategori Bisnis (opsional)"
    }
    
    @IBOutlet weak var accountStackView: UIStackView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdateTextField: UITextField!
    @IBOutlet weak var genderTextfield: UITextField!
    
    @IBOutlet weak var businessStackView: UIStackView!
    @IBOutlet weak var businessNameTextField: UITextField!
    @IBOutlet weak var businessCategoryTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewButtonConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
    
    private func setupView() {
        view.backgroundColor = .primaryGreen
        setupTextField()
        setupDatePicker()
    }
    
    private func setupTextField() {
        accountStackView.layer.cornerRadius = 8
        accountStackView.layoutMargins = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        accountStackView.isLayoutMarginsRelativeArrangement = true
        businessStackView.layer.cornerRadius = 8
        businessStackView.layoutMargins = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        businessStackView.isLayoutMarginsRelativeArrangement = true
        
        nameTextField.placeholder = Constant.namePlaceholder
        birthdateTextField.placeholder = Constant.birthdatePlaceholder
        genderTextfield.placeholder = Constant.genderPlaceholder
        businessNameTextField.placeholder = Constant.businessNamePlaceholder
        businessCategoryTextField.placeholder = Constant.businessCategoryPlaceholder
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        let nextVC = OTPController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue? {
            let height = (frame?.cgRectValue.height)!
            stackViewButtonConstraint.constant = 16
            stackViewButtonConstraint.priority = UILayoutPriority(rawValue: 100)
            bottomConstraint.constant = height
            containerViewHeight.constant = 100
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        stackViewButtonConstraint.constant = 80
        bottomConstraint.constant = 100
        containerViewHeight.constant = 0
    }
    @IBAction func birthdateTextFieldClicked(_ sender: UITextField) {
        birthdateTextField.allowsEditingTextAttributes = false
    }
    
    let datePicker = UIDatePicker()
    
    func setupDatePicker() {
        // Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        // ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(pickDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        birthdateTextField.inputAccessoryView = toolbar
        birthdateTextField.inputView = datePicker
        
    }
    
    @objc func pickDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        birthdateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
}
