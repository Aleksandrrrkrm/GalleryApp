//
//  LoginUsecase.swift
//  GalleryTest
//
//  Created by Александр Головин on 29.08.2022.
//

import Foundation
import RxSwift


protocol LoginUsecase {
    
    var tokenCondition: TokenCondition { get }
    

    func signUp(login: String, password: String) -> Single<TokenEntity>
    func refreshToken() -> Completable

}

class LoginUsecaseImp: LoginUsecase {
    
    var tokenCondition: TokenCondition
    
    private let profileSettings: Settings
    private let authenticationGateway: AuthenticationGateway

    init(authenticationGateway: AuthenticationGateway,
         settings: Settings) {
            self.authenticationGateway = authenticationGateway
            profileSettings = settings
            self.tokenCondition = profileSettings.token == nil ? .notExists: .active
        
        }

    
    func signUp(login: String, password: String) -> Single<TokenEntity> {
        authenticationGateway.signIn(login: login, password: password)
            .do(onSuccess: { token in
                self.profileSettings.token = token
                self.tokenCondition = .active
                
            }, onSubscribe: {
                self.profileSettings.token = nil
                self.tokenCondition = .notExists
            })
    }


    func refreshToken() -> Completable {
             let token = self.profileSettings.token?.refreshToken ?? ""
            return authenticationGateway.refreshToken(token)
                .do(onSuccess: { newToken in
                    self.profileSettings.token = newToken
                    self.tokenCondition = .active
                }, onError: { _ in
                    self.tokenCondition = .failedRefreshing
                }, onDispose: {
                    if self.tokenCondition == .refreshing {
                        self.tokenCondition = .failedRefreshing
                    }
                })
                .asCompletable()
        }
}
