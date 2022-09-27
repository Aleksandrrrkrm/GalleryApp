//
//  LoginGateway.swift
//  GalleryTest
//
//  Created by Александр Головин on 29.08.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient



protocol AuthenticationGateway {
    
    
    func signIn(login: String, password: String) -> Single<TokenEntity>
    
    func refreshToken(_ refreshToken: String) -> Single<TokenEntity>
    
    
}

final class ApiAuthenticationGateway: ApiBaseGateway, AuthenticationGateway {

    
    func signIn(login: String, password: String) -> Single<TokenEntity> {
        let request:ExtendedApiRequest<TokenEntity> = .loginRequest(login, password)
        return apiClient.execute(request: request)
    }
    
    func refreshToken(_ refreshToken: String) -> Single<TokenEntity> {
        let request:ExtendedApiRequest<TokenEntity> = .refreshToken(refreshToken)
        return apiClient.execute(request: request)
        
    }
}
