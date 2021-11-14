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
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewButtonConstraint: NSLayoutConstraint!
    
    private let genderData = ["Pria", "Wanita", "Lainnya"]
    private let businessCategoryData = ["Makanan & Minuman", "Hobi", "Pakaian", "Lainnya"]
    
    var user: User = User()
    private let authVM = AuthenticationViewModel()
    let datePicker = UIDatePicker()
    let genderPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupKeyboard()
        setupNavigationBar()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func configure(user: User) {
        self.user = user
    }
    
    private func setupView() {
        view.backgroundColor = .primaryGreen
        warningLabel.text = ""
        warningLabel.textColor = .alert
        setupTextField()
        setupNavigationBar()
        setupDatePicker()
        setupPicker()
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
        
        nameTextField.delegate = self
        birthdateTextField.delegate = self
        genderTextfield.delegate = self
        businessNameTextField.delegate = self
        businessCategoryTextField.delegate = self
    }
    
    // MARK: - Action
    @IBAction func nextButton(_ sender: UIButton) {
        self.warningLabel.text = ""
        if saveUser() {
            authVM.registerUser(user: self.user) { result in
                if result {
                    let nextVC = OTPController()
                    nextVC.configure(user: self.user)
                    if let navigationController = self.navigationController {
                        navigationController.pushViewController(nextVC, animated: true)
                    }
                } else {
                    self.warningLabel.text = self.authVM.response
                }
            }
        }
    }
    
    @objc private func backNavigation(_ sender: UIBarButtonItem) {
        guard let navigation = self.navigationController else { return }
        navigation.popViewController(animated: true)
    }
}

// MARK: - Keyboard
extension AccountInformationController {
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
}

// MARK: - Textfield
extension AccountInformationController: UITextFieldDelegate {
    private func switchTextField(_ textField: UITextField) {
        switch textField {
        case self.nameTextField:
            self.birthdateTextField.becomeFirstResponder()
        case self.birthdateTextField:
            self.genderTextfield.becomeFirstResponder()
        case self.genderTextfield:
            self.businessNameTextField.becomeFirstResponder()
        case self.businessNameTextField:
            self.businessCategoryTextField.becomeFirstResponder()
        default:
            self.businessCategoryTextField.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchTextField(textField)
        return true
    }
    
    private func saveUser() -> Bool {
        if self.checkTextField() {
            self.user.name = nameTextField.text ?? ""
            self.user.birthDate = birthdateTextField.text ?? ""
            self.user.gender = genderTextfield.text ?? ""
            
            self.user.businessName = businessNameTextField.text ?? ""
            self.user.businessCategory = businessCategoryTextField.text ?? ""
            
            return true
        } else {
            self.warningLabel.text = "Please Fill all the textfield"
            return false
        }
    }
    
    @IBAction func birthdateTextFieldClicked(_ sender: UITextField) {
        birthdateTextField.allowsEditingTextAttributes = false
    }
    
    // MARK: - Date Picker
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
    
    private func checkTextField() -> Bool {
        if (nameTextField.text?.isEmpty)! {
            return false
        } else if (birthdateTextField.text?.isEmpty)! {
            return false
        } else if (genderTextfield.text?.isEmpty)! {
            return false
        }
        return true
    }
}

// MARK: - PickerView
extension AccountInformationController: UIPickerViewDelegate, UIPickerViewDataSource {
    private func setupPicker() {
        let genderPicker = UIPickerView()
        genderPicker.delegate = self
        genderPicker.tag = 0
        
        let categoryPicker = UIPickerView()
        categoryPicker.delegate = self
        categoryPicker.tag = 1
        
        // ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([spaceButton, doneButton], animated: false)
        
        genderTextfield.inputAccessoryView = toolbar
        genderTextfield.inputView = genderPicker
        businessCategoryTextField.inputAccessoryView = toolbar
        businessCategoryTextField.inputView = categoryPicker
    }
    
    @objc func donePicker() {
          view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return genderData.count
        } else {
            return businessCategoryData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return genderData[row]
        } else {
            return businessCategoryData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            genderTextfield.text = genderData[row]
        } else {
            businessCategoryTextField.text = businessCategoryData[row]
        }
    }
}
