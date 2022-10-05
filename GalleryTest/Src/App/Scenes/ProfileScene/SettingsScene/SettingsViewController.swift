//
//  SettingsViewController.swift
//  GalleryTest
//
//  Created by Александр Головин on 23.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    
    //MARK: - OUTLETS
    internal var presenter: SettingsPresenter?
    var nameTextField = CustomTextField()
    var birthdayTextField = CustomTextField()
    var emailTextField = CustomTextField()
    var passwordTextField = CustomTextField()
    var newPasswordTextField = CustomTextField()
    var confirmPasswordTextField = CustomTextField()
    let imageView = UIImageView()
    let userNameLabel = UILabel()
    let emailLabel = UILabel()
    let passwordLabel = UILabel()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let deleteLabel = UILabel()
    let deleteButton = UIButton(type: .system)
    let signOutButton = UIButton(type: .system)
    
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SettingsConfigurator.configure(view: self)
        configureViews()
        
        let textFieldArray = [nameTextField, birthdayTextField, emailTextField, passwordTextField, newPasswordTextField, confirmPasswordTextField]
        
        for textField in textFieldArray {
            textField.delegate = self
        }
    }
    
    
    //MARK: - CONFIGURE VIEWS
    private func configureViews() {
        
        SettingsConfigurator.configure(view: self)
        configureall()
        presenter?.currentUserInfo()
        settingsKeyboard()
        
    }
    

    //settingsViewDidLoad
    private func configureall() {
        
        self.view.backgroundColor = .white
        setupScrollView()
        configureNavTitle()
        configureImageView()
        configureNameLabel()
        configureNameTextField()
        configureBirthdayTextField()
        configureEmailLabel()
        configureEmailTextField()
        configurePasswordLabel()
        configurePasswordTextFields()
        configureNewPasswordTextFields()
        configureConfirmPasswordTextFields()
        configureDeleteLabel()
        configureSignOutButton()
    }
    
    
    // NavigationTitle
    private func configureNavTitle() {

        let rightButtonItem = UIBarButtonItem.init(title: R.string.scenes.save(),
                                                   style: .done,
                                                   target: self,
                                                   action: #selector(saveButtonPressed))
        rightButtonItem.tintColor = R.color.appPink()
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    
    func setupScrollView(){
                
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.bottom.equalToSuperview()
        }
    }
    
    
    //MARK: - SceneViews
    
    // imageView
    private func configureImageView() {
        imageView.layer.borderColor = .init(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = R.image.photo()
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalToSuperview().inset(10)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
    
    // nameLabel
    private func configureNameLabel() {
        userNameLabel.text = R.string.scenes.personalData()
        contentView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(87)
            make.height.equalTo(16)
            make.centerX.equalTo(scrollView)
            make.top.equalTo(imageView.snp.bottom).offset(44)
        }
    }
    
    //nameTextField
    private func configureNameTextField() {
        
        nameTextField.leftViewMode = .always
        nameTextField.configureView(for: Images.name)
        nameTextField.isSecureTextEntry = false
        contentView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(35)
            make.centerX.equalTo(scrollView)
            make.top.equalTo(userNameLabel.snp.bottom).offset(20)
        }
    }
    
    //birthdayTextField
    private func configureBirthdayTextField() {
        
        birthdayTextField.placeholder = R.string.scenes.birthday()
        birthdayTextField.configureView(for: Images.birthday)
        birthdayTextField.isSecureTextEntry = false
        contentView.addSubview(birthdayTextField)
        birthdayTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(35)
            make.centerX.equalTo(scrollView)
            make.top.equalTo(nameTextField.snp.bottom).offset(29)
        }
    }
    
    
    //emailLabel
    private func configureEmailLabel() {
        
        emailLabel.text = R.string.scenes.emailAdress()
        contentView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
            make.centerX.equalTo(scrollView)
            make.top.equalTo(birthdayTextField.snp.bottom).offset(39)
        }
    }
    
    
    //emailTextField
    private func configureEmailTextField() {
        
        emailTextField.configureView(for: Images.email)
        emailTextField.isSecureTextEntry = false
        contentView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(35)
            make.centerX.equalTo(scrollView)
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
        }
    }
    
    
    //passwordLabel
    private func configurePasswordLabel() {
        
        passwordLabel.text = R.string.scenes.password()
        contentView.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
            make.centerX.equalTo(scrollView)
            make.top.equalTo(emailTextField.snp.bottom).offset(39)
        }
    }
    
    
    //passwordTextLabel
    private func configurePasswordTextFields() {
        
        passwordTextField.placeholder = R.string.scenes.oldPassword()
        passwordTextField.configureView(for: Images.password)
        contentView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(35)
            make.centerX.equalTo(scrollView)
            make.top.equalTo(passwordLabel.snp.bottom).offset(20)
        }
    }
   
    
    //passwordTextField
    private func configureNewPasswordTextFields() {
        
        newPasswordTextField.placeholder = R.string.scenes.newPassword()
        newPasswordTextField.configureView(for: Images.password)
        contentView.addSubview(newPasswordTextField)
        newPasswordTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(35)
            make.centerX.equalTo(scrollView)
            make.top.equalTo(passwordTextField.snp.bottom).offset(29)
        }
    }
    
   
    //passwordTextField
    private func configureConfirmPasswordTextFields() {
        confirmPasswordTextField.placeholder = R.string.scenes.confirmPassword()
        confirmPasswordTextField.configureView(for: Images.password)
        contentView.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(35)
            make.centerX.equalTo(scrollView)
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(29)
        }
    }
    
    
    //configureDeleteLabel
    private func configureDeleteLabel() {
        deleteLabel.font = UIFont(name: deleteLabel.font.fontName,
                                  size: 15)
        deleteLabel.text = R.string.scenes.youCan()
        contentView.addSubview(deleteLabel)
        deleteLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(39)
        }
        deleteButton.setTitle(R.string.scenes.deleteAcc(),
                              for: .normal)
        deleteButton.tintColor = R.color.appPink()
        deleteButton.titleLabel?.font = UIFont(name: deleteLabel.font.fontName,
                                               size: 15)
        contentView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.left.equalTo(deleteLabel.snp.right)
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(33)
        }
    }
    
    
    //signOutButton
    private func configureSignOutButton() {
        signOutButton.setTitle(R.string.scenes.signOut(),
                               for: .normal)
        signOutButton.tintColor = R.color.appPink()
        signOutButton.titleLabel?.font = UIFont(name: deleteLabel.font.fontName,
                                                size: 15)
        signOutButton.addTarget(self, action: #selector(signOut),
                                for: .touchUpInside)
        contentView.addSubview(signOutButton)
        signOutButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(deleteLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(120)
        }
    }
    
    
    //MARK: - USAGE
    
    @objc func signOut() {
        
        let alert  = UIAlertController(title: R.string.scenes.signOut(),
                                       message: R.string.scenes.areYouShure(),
                                       preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.scenes.signOut(),
                                      style: .default,
                                      handler: { _ in
            ProfileSettings().clearUserData()
            self.presenter?.openStartScreen()
        }))
        alert.addAction(UIAlertAction(title: R.string.scenes.cancel(),
                                      style: .cancel,
                                      handler: nil))
        self.present(alert, animated: true,
                     completion: nil)
        
    }
    
    @objc func saveButtonPressed() { }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textFieldArray = [nameTextField, birthdayTextField, emailTextField, passwordTextField, newPasswordTextField, confirmPasswordTextField]
        for textField in textFieldArray {
            textField.resignFirstResponder()
        }
        return true
    }
    
}


//MARK: - EXTENSION
extension SettingsViewController: SettingsView {
    
    
}
