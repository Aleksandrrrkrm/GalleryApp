//
//  SettingsView.swift
//  GalleryTest
//
//  Created by Александр Головин on 23.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

protocol SettingsView {
    
    var nameTextField: CustomTextField { get set }
    var birthdayTextField: CustomTextField { get set }
    var emailTextField: CustomTextField { get set }
    var passwordTextField: CustomTextField { get set }
    var newPasswordTextField: CustomTextField { get set }
    var confirmPasswordTextField: CustomTextField { get set }
    
}
