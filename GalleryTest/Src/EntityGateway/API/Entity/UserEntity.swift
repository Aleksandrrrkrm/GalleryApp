//
//  UserEntity.swift
//  GalleryTest
//
//  Created by Александр Головин on 14.09.2022.
//

import Foundation
import RxNetworkApiClient

class UserEntity: JsonBodyConvertible {
    
    var id: Int?
    var username: String?
    var roles: [String]?
    var email: String?
    var phone: String?
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var fullName: String?
    var newEmail: String?
    var newPhone: String?
    var dateOfBirth: String?
    var plainPassword: String?
    var isExternalUser: Bool?
    var isAgreementAccepted: Bool?
    var enabled: Bool?
    
    init(_ id: Int?,
         _ username: String?,
         _ roles: [String]?,
         _ email: String?,
         _ phone: String?,
         _ firstName: String?,
         _ middleName: String?,
         _ lastName: String?,
         _ fullName: String?,
         _ newEmail: String?,
         _ newPhone: String?,
         _ dateOfBirth: String?,
         _ plainPassword: String?,
         _ isExternalUser: Bool?,
         _ isAgreementAccepted: Bool?,
         _ enabled: Bool?) {
        self.id = id
        self.username = username
        self.roles = roles
        self.email = email
        self.phone = phone
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.fullName = fullName
        self.newEmail = newEmail
        self.newPhone = newPhone
        self.dateOfBirth = dateOfBirth
        self.plainPassword = plainPassword
        self.isExternalUser = isExternalUser
        self.enabled = enabled
    }
    
    init(user: RegistrationEntity) {
        self.firstName = user.username
        self.email = user.email
        self.plainPassword = user.password
       
    }
}

// MARK: - UserApiEntity
class UserApiEntity: JsonBodyConvertible {
    
    var id: String?
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var email: String?
    var phone: String?
    var username: String?
    var plainPassword: String?
    var dateOfBirth: String?
    var isAgreementAccepted: Bool?
    
    
    init(id: String? = nil,
         username: String? = nil,
         firstName: String? = nil,
         middleName: String? = nil,
         lastName: String? = nil,
         email: String? = nil,
         phone: String? = nil,
         plainPassword: String? = nil) {
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.username = username
        self.plainPassword = plainPassword
       
    }

    init(user: UserEntity) {
        self.firstName = user.firstName
        self.middleName = user.middleName
        self.lastName = user.lastName
        self.email = user.email
        self.phone = user.phone
        self.username = user.username
        self.plainPassword = user.plainPassword
        self.dateOfBirth = user.dateOfBirth
        self.isAgreementAccepted = user.isAgreementAccepted
    }
}

extension UserEntity {
    
    var isFullAccount: Bool {
        !self.firstName.isEmptyOrNil &&
            !self.lastName.isEmptyOrNil &&
            !self.dateOfBirth.isEmptyOrNil &&
            !self.phone.isEmptyOrNil &&
            !self.email.isEmptyOrNil
    }
    
    var userEditingEntity: UserEditingEntity {
        UserEditingEntity(user: self)
    }
}

// MARK: - UserEditingEntity
class UserEditingEntity: JsonBodyConvertible {
    
    var id: String?
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var email: String?
    var phone: String?
    var dateOfBirth: String?
    var enabled: Bool?
    
    init(id: String? = nil,
         firstName: String? = nil,
         middleName: String? = nil,
         lastName: String? = nil,
         email: String? = nil,
         phone: String? = nil,
         dateOfBirth: String? = nil,
         enabled: Bool? = nil) {
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.dateOfBirth = dateOfBirth
        self.enabled = enabled
    }

    init(user: UserEntity) {
        self.firstName = user.firstName
        self.middleName = user.middleName
        self.lastName = user.lastName
        self.email = user.email
        self.phone = user.phone
        self.dateOfBirth = user.dateOfBirth
        self.enabled = user.enabled
        
    }
}
