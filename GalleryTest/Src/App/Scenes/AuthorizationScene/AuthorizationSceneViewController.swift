//
//  AuthorizationSceneViewController.swift
//  GalleryTest
//
//  Created by Александр Головин on 25.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit
import DITranquillity
import PKHUD

class AuthorizationSceneViewController: UIViewController {
    
    internal var presenter: AuthorizationScenePresenter?
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonAuth: UIButton!
    @IBOutlet weak var buttonRegister: UIButton!    
    @IBOutlet weak var errorRegisterLabel: UILabel!
    var userNameButton = UIButton(type: .system)
    var passwordButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        configureButtons()
        errorLabel(hide: true)
        settingsKeyboard()
        configureTextFieldButton()
        
        let backBarButtonItem = UIBarButtonItem(title: R.string.scenes.cancel(), style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // MARK: - Configure Views
   private func configureButtons() {
        buttonAuth.layer.cornerRadius = 5
        buttonAuth.addTarget(self,
                             action: #selector(click(button:)),
                             for: .touchUpInside)
        buttonRegister.addTarget(self,
                                 action: #selector(click(button:)),
                                 for: .touchUpInside)
    }
    
    internal func errorLabel(hide: Bool) {
        errorRegisterLabel.isHidden = hide
    }
    
    private func configureTextFieldButton() {
        userNameButton.setImage(R.image.name(), for: .normal)
        userNameButton.isUserInteractionEnabled = false
        textFieldEmail.rightViewMode = UITextField.ViewMode.always
        textFieldEmail.rightView = userNameButton
        
        userNameButton.contentMode = .scaleAspectFit
        userNameButton.tintColor = .init(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        userNameButton.backgroundColor = .clear
        userNameButton.snp.makeConstraints { make in
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
    
    // MARK: - Usage
    @objc func click(button sender: UIButton) {
        switch sender {
        case buttonAuth:
            presenter?.loginUser(userName: clearText(textField: textFieldEmail),
                                 password: clearText(textField: textFieldPassword))
        case buttonRegister:
            presenter?.regButtonPressed()
        default:
            return
        }
    }
    
    func clearText(textField: UITextField) -> String {
        textField.text?.trimmingCharacters(in: .whitespaces) ?? ""
    }
    
    
    @IBAction func tap(_ sender: Any) {
        textFieldEmail.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
    }
    
}
// MARK: - Extensions

extension AuthorizationSceneViewController: AuthorizationSceneView { }











