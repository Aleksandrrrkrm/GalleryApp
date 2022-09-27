//
//  RegistrationUsecase.swift
//  GalleryTest
//
//  Created by Александр Головин on 26.08.2022.
//

import Foundation
import RxSwift

protocol RegistrationUsecase {
    func signUp(user: RegistrationEntity) -> Completable
}

class RegistrationUsecaseImp: RegistrationUsecase {
    
    private let registrationGateway: RegistrationGateway
    
    init (registrationGateway: RegistrationGateway) {
        self.registrationGateway = registrationGateway
    }
    
    func signUp(user: RegistrationEntity) -> Completable {
        registrationGateway.signUp(user: user)
    }
}
