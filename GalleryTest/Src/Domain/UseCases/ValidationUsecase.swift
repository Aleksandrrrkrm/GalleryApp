//
//  ValidationUsecase.swift
//  GalleryTest
//
//  Created by Александр Головин on 05.09.2022.
//

import Foundation
import UIKit



protocol ValidationUsecase {
    
    func validationUserName(userName: String) throws
    func validationEmail(email: String) throws
    func validationPassword(password: String) throws
    func validationConfirmPassword(password: String, confirmPassword: String) throws
}



class ValidationUsecaseImp: ValidationUsecase {
    
    func validationUserName(userName: String) throws {
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", Regex.nameRegex.rawValue)
        if !namePredicate.evaluate(with: userName) {
            throw ErrorValidate.invalidSymbol
        }
    }
    
    func validationEmail(email: String) throws {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", Regex.emailRegex.rawValue)
        if !emailPredicate.evaluate(with: email) {
            throw ErrorValidate.invalidEmail
        }
    }
    
    func validationPassword(password: String) throws {
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", Regex.passwordRegex.rawValue)
        if !passwordPredicate.evaluate(with: password) {
            throw ErrorValidate.lengthPassword
        }
    }
    
    func validationConfirmPassword(password: String, confirmPassword: String) throws {
        if password != confirmPassword {
            throw ErrorValidate.passwordWrong
        }
    }
}


