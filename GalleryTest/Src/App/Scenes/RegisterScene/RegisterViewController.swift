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
    
    // UIlabel for validation
    @IBOutlet weak var errorLabel: UILabel!
    
    
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
        
    }
    
    // MARK: - Configure Views
    func configureButtons() {
        
        
        buttonRegister.backgroundColor = UIColor.black
        buttonRegister.layer.cornerRadius = 5
        buttonRegister.addTarget(self, action: #selector(click(button:)), for: .touchUpInside)
        buttonLogin.layer.cornerRadius = 5
        buttonLogin.addTarget(self, action: #selector(click(button:)), for: .touchUpInside)
        
    }
    
 
    
    func configureTextFields() {
        
        errorLabel.font = UIFont(name: R.string.scenes.gillSans(), size: 14)
        errorLabel.textColor = UIColor(cgColor: (CGColor(red: 192/255, green: 82/255, blue: 125/255, alpha: 1)))
        
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
            
            validation()
            
            if isTextFieldsValid == true {
                presenter?.registerUser(data: data)
            } else {
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
        
        return textField.text?.trimmingCharacters(in: .whitespaces) ?? R.string.scenes.emptyLine()
        
    }
    
    // hide keyboard
    @IBAction func tap(_ sender: Any) {
        
        let textFieldArray = [textFieldEmail,textFieldUserName,textFieldBirthday,textFieldPassword,textFieldConfirmPassword]
        
        for textField in textFieldArray {
            textField?.resignFirstResponder()
        }
        
    }
    
    
    // MARK: - Validation
    // userName
    
    func validation() {
        
        guard let result = presenter?.validateUserName(userName: clearText(textField: textFieldUserName), email: clearText(textField: textFieldEmail), password: clearText(textField: textFieldPassword), confirmPassword: clearText(textField: textFieldConfirmPassword)) else {
            self.isTextFieldsValid = true
            return
        }
        errorLabel.text = result
        self.isTextFieldsValid = false
    }
}



//MARK: - Extensions
extension RegisterViewController: RegisterView {
    
    
    
}


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
