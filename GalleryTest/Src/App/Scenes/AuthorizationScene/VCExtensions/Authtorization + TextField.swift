//
//  Authtorization + .swift
//  GalleryTest
//
//  Created by Александр Головин on 27.09.2022.
//

import UIKit

extension AuthorizationSceneViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case textFieldEmail:
            textFieldPassword.becomeFirstResponder()
        case textFieldPassword:
            textField.resignFirstResponder()
        default:
            return true
        }
        return true
    }
    
}
