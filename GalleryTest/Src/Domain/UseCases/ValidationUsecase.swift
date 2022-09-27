//
//  ValidationUsecase.swift
//  GalleryTest
//
//  Created by Александр Головин on 05.09.2022.
//

import Foundation
import UIKit



protocol ValidationUsecase {
    
    func validation(userName: String, email: String, password: String, confirmPassword: String) throws

}



class ValidationUsecaseImp: ValidationUsecase {
    
    
    func validation(userName: String, email: String, password: String, confirmPassword: String) throws {
        
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", Regex.nameRegex.rawValue)
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", Regex.emailRegex.rawValue)
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", Regex.passwordRegex.rawValue)
        
        if !namePredicate.evaluate(with: userName) {
            throw ErrorValidate.invalidSymbol
        }
        
        if !emailPredicate.evaluate(with: email) {
            throw ErrorValidate.invalidEmail
        }
        
        if !passwordPredicate.evaluate(with: password) {
            throw ErrorValidate.lengthPassword
        }
        
        if password != confirmPassword {
            throw ErrorValidate.passwordWrong
        }
    }
    
    
}


