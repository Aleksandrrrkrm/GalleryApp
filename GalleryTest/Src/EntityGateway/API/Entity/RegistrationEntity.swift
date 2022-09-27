//
//  CreateRegistrationRequestApiEntity.swift
//  GalleryTest
//
//  Created by Александр Головин on 26.08.2022.
//

import Foundation
import RxNetworkApiClient

struct RegistrationEntity: JsonBodyConvertible {
    
    let email: String
    let password: String
    let username: String

    init(email: String,
         password: String,
         username: String) {

        self.email = email
        self.password = password
        self.username = username
    }
    
}

enum Regex: String {
    
    case nameRegex = "^([A-Za-z0-9]){3,20}$"
    case emailRegex = "([A-Za-z0-9!#$%&'*+-/=?^_`{|}~]){1,64}@([a-z0-9!#$%&'*+-/=?^_`{|}~]){1,64}\\.([a-z0-9]){2,64}"
    case passwordRegex = "([A-Za-z0-9!#$%&'*+-/=?^_`{|}~]){6,22}"
}
