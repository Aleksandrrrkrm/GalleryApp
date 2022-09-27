//
//  RegisterPresenter.swift
//  GalleryTest
//
//  Created by Александр Головин on 24.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import UIKit

protocol RegisterPresenter {
    
    func registerUser(data: RegistrationEntity)

    func authButtonPressed()
    
    func validateUserName(userName: String, email: String, password: String, confirmPassword: String) -> String?
    
}
