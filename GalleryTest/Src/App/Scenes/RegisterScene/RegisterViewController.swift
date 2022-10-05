//
//  RegisterViewController.swift
//  GalleryTest
//
//  Created by Александр Головин on 24.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit
import SnapKit

struct UserModel {
    let email: String?
    let password: String?
    let username: String?
}


class RegisterViewController: UIViewController {
    
    
    internal var presenter: RegisterPresenter?
    
    // MARK: - @IBOutlets
    // textField and buttons
    // TODO: вид текст филда
//    @IBOutlet weak var allTextFIelds: [UITextField]!
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldBirthday: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var buttonLogin: UIButton!
    
    var userNameButton = UIButton(type: .system)
    var birthdayButton = UIButton(type: .system)
    var emailButton = UIButton(type: .system)
    var passwordButton = UIButton(type: .system)
    var confirmPasswordButton = UIButton(type: .system)
    
    // UIlabel for validation
    @IBOutlet weak var errorConfirmPasswordLabel: UILabel!
    @IBOutlet weak var errorNameLabel: UILabel!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    
    var isTextFieldsValid: Bool?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let textFieldArray = [textFieldEmail, textFieldUserName, textFieldBirthday, textFieldPassword, textFieldConfirmPassword]
        for textField in textFieldArray {
            textField?.delegate = self
        }
        configureButtons()
        configureTextFields()
        settingsKeyboard()
        configureTextFieldButton()
        let backBarButtonItem = UIBarButtonItem(title: R.string.scenes.cancel(), style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // MARK: - Configure Views
    private func configureButtons() {
        buttonRegister.backgroundColor = UIColor.black
        buttonRegister.layer.cornerRadius = 5
        buttonRegister.addTarget(self, action: #selector(click(button:)), for: .touchUpInside)
        buttonLogin.layer.cornerRadius = 5
        buttonLogin.addTarget(self, action: #selector(click(button:)), for: .touchUpInside)
    }
    
    private func configureTextFieldButton() {
        
        userNameButton.setImage(R.image.name(), for: .normal)
        userNameButton.isUserInteractionEnabled = false
        textFieldUserName.rightViewMode = UITextField.ViewMode.always
        textFieldUserName.rightView = userNameButton
        
        userNameButton.contentMode = .scaleAspectFit
        userNameButton.tintColor = .init(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        userNameButton.backgroundColor = .clear
        userNameButton.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
        
        birthdayButton.setImage(R.image.calendar(), for: .normal)
        birthdayButton.isUserInteractionEnabled = false
        textFieldBirthday.rightViewMode = UITextField.ViewMode.always
        textFieldBirthday.rightView = birthdayButton
        
        birthdayButton.contentMode = .scaleAspectFit
        birthdayButton.tintColor = .init(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        birthdayButton.backgroundColor = .clear
        birthdayButton.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
        
        emailButton.setImage(R.image.email(), for: .normal)
        emailButton.isUserInteractionEnabled = false
        textFieldEmail.rightViewMode = UITextField.ViewMode.always
        textFieldEmail.rightView = emailButton
        
        emailButton.contentMode = .scaleAspectFit
        emailButton.tintColor = .init(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        emailButton.backgroundColor = .clear
        emailButton.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
        
        passwordButton.setImage(R.image.eyeClose(), for: .normal)
        passwordButton.addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)
        textFieldPassword.rightViewMode = UITextField.ViewMode.always
        textFieldPassword.rightView = passwordButton
        
        passwordButton.contentMode = .scaleAspectFit
        passwordButton.tintColor = .init(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        passwordButton.backgroundColor = .clear
        passwordButton.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
        
        confirmPasswordButton.setImage(R.image.eyeClose(), for: .normal)
        confirmPasswordButton.addTarget(self, action: #selector(showConfirmPassword(_:)), for: .touchUpInside)
        textFieldConfirmPassword.rightViewMode = UITextField.ViewMode.always
        textFieldConfirmPassword.rightView = confirmPasswordButton
        
        confirmPasswordButton.contentMode = .scaleAspectFit
        confirmPasswordButton.tintColor = .init(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        confirmPasswordButton.backgroundColor = .clear
        confirmPasswordButton.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
    }
    
    @objc private func showConfirmPassword(_ sender: UIButton) {
        if textFieldConfirmPassword.isSecureTextEntry == true {
            sender.setImage(R.image.eyeOpen(), for: .normal)
            textFieldConfirmPassword.isSecureTextEntry = false
        }
        else {
            textFieldConfirmPassword.isSecureTextEntry = true
            sender.setImage(R.image.eyeClose(), for: .normal)
        }
    }
    
    @objc private func showPassword(_ sender: UIButton) {
        if textFieldPassword.isSecureTextEntry == true {
            sender.setImage(R.image.eyeOpen(), for: .normal)
            textFieldPassword.isSecureTextEntry = false
        }
        else {
            textFieldPassword.isSecureTextEntry = true
            passwordButton.setImage(R.image.eyeClose(), for: .normal)
        }
    }
    
   private func configureTextFields() {
       
        errorConfirmPasswordLabel.font = UIFont(name: R.string.scenes.gillSans(), size: 14)
        errorConfirmPasswordLabel.textColor = UIColor(cgColor: (CGColor(red: 192/255, green: 82/255, blue: 125/255, alpha: 1)))
       
       errorPasswordLabel.font = UIFont(name: R.string.scenes.gillSans(), size: 14)
       errorPasswordLabel.textColor = UIColor(cgColor: (CGColor(red: 192/255, green: 82/255, blue: 125/255, alpha: 1)))
       
       errorNameLabel.font = UIFont(name: R.string.scenes.gillSans(), size: 14)
       errorNameLabel.textColor = UIColor(cgColor: (CGColor(red: 192/255, green: 82/255, blue: 125/255, alpha: 1)))
       
       errorEmailLabel.font = UIFont(name: R.string.scenes.gillSans(), size: 14)
       errorEmailLabel.textColor = UIColor(cgColor: (CGColor(red: 192/255, green: 82/255, blue: 125/255, alpha: 1)))

        let passwordAttribured = NSMutableAttributedString(string: .identifier.password)
        let userNameAttribured = NSMutableAttributedString(string: .identifier.userName)
        let emailAttribured = NSMutableAttributedString(string: .identifier.email)
        let confirmPasswordAttribured = NSMutableAttributedString(string: .identifier.confirmPassword)
        let asterix = NSAttributedString(string: R.string.scenes.asterix(), attributes: [.foregroundColor: UIColor.red])
        
        passwordAttribured.append(asterix)
        userNameAttribured.append(asterix)
        emailAttribured.append(asterix)
        confirmPasswordAttribured.append(asterix)

        self.textFieldPassword.attributedPlaceholder = passwordAttribured
        self.textFieldUserName.attributedPlaceholder = userNameAttribured
        self.textFieldEmail.attributedPlaceholder = emailAttribured
        self.textFieldConfirmPassword.attributedPlaceholder = confirmPasswordAttribured
    }
    
    
    //MARK: - Usage
    @objc func click(button sender: UIButton) {
        let data = RegistrationEntity(email: clearText(textField: textFieldEmail), password: clearText(textField: textFieldPassword), username: clearText(textField: textFieldUserName))
        switch sender {
        case buttonRegister:
            if isTextFieldsValid == true {
                presenter?.registerUser(data: data)
            } else {
                let alert  = UIAlertController(title: R.string.scenes.warning(),
                                               message: R.string.errors.emptyFields(),
                                               preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: R.string.scenes.ok(),
                                              style: .default,
                                              handler: nil))
                self.present(alert,
                             animated: true,
                             completion: nil)
                return
            }
        case buttonLogin:
            presenter?.authButtonPressed()
        default:
            return
        }
    }
    
    // text without spaces
    func clearText(textField: UITextField) -> String {
        textField.text?.trimmingCharacters(in: .whitespaces) ?? R.string.scenes.emptyLine()
    }
    
    // hide keyboard
    @IBAction func tap(_ sender: Any) {
        let textFieldArray = [textFieldEmail,textFieldUserName,textFieldBirthday,textFieldPassword,textFieldConfirmPassword]
        for textField in textFieldArray {
            textField?.resignFirstResponder()
        }
      
    }
        
    // MARK: - Validation

    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case textFieldUserName:
            if textFieldUserName.text != "" {
            guard let result = presenter?.validateUserName(userName: clearText(textField: textFieldUserName)) else {
                self.errorNameLabel.text = nil
                self.isTextFieldsValid = true
                return
            }
                self.errorNameLabel.text = result
                self.isTextFieldsValid = false
            } else {
                self.errorNameLabel.text = nil
                return
            }
        case textFieldEmail:
            if textFieldEmail.text != "" {
            guard let result = presenter?.validateEmail(email: clearText(textField: textFieldEmail)) else {
                self.errorEmailLabel.text = nil
                self.isTextFieldsValid = true
                return
            }
                self.errorEmailLabel.text = result
                self.isTextFieldsValid = false
            } else {
                self.errorEmailLabel.text = nil
                return
            }
        case textFieldPassword:
            if textFieldPassword.text != "" {
            guard let result = presenter?.validatePassword(password: clearText(textField: textFieldPassword)) else {
                self.errorPasswordLabel.text = nil
                self.isTextFieldsValid = true
                return
            }
                    self.errorPasswordLabel.text = result
                    self.isTextFieldsValid = false
                } else {
                    self.errorPasswordLabel.text = nil
                    return
                }
        case textFieldConfirmPassword:
            if textFieldConfirmPassword.text != "" {
            guard let result = presenter?.validateConfirmPassword(password: clearText(textField: textFieldPassword), confirmPassword: clearText(textField: textFieldConfirmPassword)) else {
                self.errorConfirmPasswordLabel.text = nil
                self.isTextFieldsValid = true
                return
            }
                        self.errorConfirmPasswordLabel.text = result
                        self.isTextFieldsValid = false
                    } else {
                        self.errorConfirmPasswordLabel.text = nil
                        return
                    }
        default:
            return
        }
    }
    
    
}

//MARK: - Extensions
extension RegisterViewController: RegisterView { }

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case textFieldUserName:
            textFieldBirthday.becomeFirstResponder()
        case textFieldBirthday:
            textFieldEmail.becomeFirstResponder()
        case textFieldEmail:
            textFieldPassword.becomeFirstResponder()
        case textFieldPassword:
            textFieldConfirmPassword.becomeFirstResponder()
        case textFieldConfirmPassword:
            textField.resignFirstResponder()
        default:
            return true
        }
        return true
    }
}
