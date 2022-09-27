//
//  UserGateway.swift
//  GalleryTest
//
//  Created by Александр Головин on 23.09.2022.
//

import Foundation
import RxNetworkApiClient
import RxSwift



protocol UserGateway {
    
    
    func getCurrentUser() -> Single<CurrentUser>
    
    
}

final class UserGatewayImp: ApiBaseGateway, UserGateway {

    func getCurrentUser() -> Single<CurrentUser> {
        let request:ExtendedApiRequest<CurrentUser> = .getAccountRequest()
        return apiClient.execute(request: request)
        
    }
    
    
}
