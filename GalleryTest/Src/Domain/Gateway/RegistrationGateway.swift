//
//  RegistrationGateway.swift
//  GalleryTest
//
//  Created by Александр Головин on 26.08.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol RegistrationGateway {
    
    
    func signUp(user: RegistrationEntity) -> Completable
    
    
}

final class RegistrationGatewayImp: ApiBaseGateway, RegistrationGateway {
    
    
    func signUp(user: RegistrationEntity) -> Completable {
        let request:ExtendedApiRequest<RegistrationEntity> = .signUp(user)
        return apiClient.execute(request: request).asCompletable()
    }
    
    
}
