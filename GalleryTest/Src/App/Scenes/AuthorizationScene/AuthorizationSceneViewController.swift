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
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        configureButtons()
        errorLabel(hide: true)
        settingsKeyboard()
    }
    
    // MARK: - Configure Views
    func configureButtons() {
        
        buttonAuth.layer.cornerRadius = 5
        buttonAuth.addTarget(self,
                             action: #selector(click(button:)),
                             for: .touchUpInside)
        buttonRegister.addTarget(self,
                                 action: #selector(click(button:)),
                                 for: .touchUpInside)
        
    }
    
    
    func errorLabel(hide: Bool) {
        
        errorRegisterLabel.isHidden = hide
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











