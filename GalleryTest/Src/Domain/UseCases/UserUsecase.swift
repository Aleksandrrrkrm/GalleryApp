//
//  UserUsecase.swift
//  GalleryTest
//
//  Created by Александр Головин on 23.09.2022.
//

import Foundation
import RxNetworkApiClient
import RxSwift


protocol UserUsecase {
    
    func getCurrentUser() -> Single<CurrentUser>
    
}

final class UserUsecaseImp: UserUsecase {
    
    private let userGateway: UserGateway
    
    init (userGateway: UserGateway) {
        self.userGateway = userGateway
    }
    
    func getCurrentUser() -> Single<CurrentUser> {
        userGateway.getCurrentUser()
    }
}
