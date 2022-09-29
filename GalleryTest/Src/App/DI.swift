//
//  DI.swift
//  GalleryTest
//
//  Created by Александр Головин on 26.08.2022.
//

import Foundation
import DITranquillity
import RxNetworkApiClient

class DI {
    
    static var container = DIContainer()
    /// Основные зависимости
//     swiftlint:disable function_body_length
    static func initDependencies(_ appDelegate: AppDelegate) {
      
        // MARK: - Interceptor init

        self.container.register(AuthInterceptor.init)
            .as(AuthInterceptor.self)
            .lifetime(.single)
        
        self.container.register {
            AuthResponseHandler(appDelegate, $0, $1, $2)
        }
        .as(AuthResponseHandler.self)
        .lifetime(.single)
        
        // MARK: - ApiClient Init

        self.container.register { () -> ApiClientImp in
                       
                let client = ApiClientImp.defaultInstance(host: Config.apiEndpoint)
                client.responseHandlersQueue.append(JsonResponseHandler())
                client.responseHandlersQueue.append(NSErrorResponseHandler())
                
                client.interceptors.append(JsonContentInterceptor())
                client.interceptors.append(ExtraPathInterceptor())
                return client
        }
        .as(ApiClient.self)
        .injection(cycle: true) {
                    $0.responseHandlersQueue.insert($1 as AuthResponseHandler, at: 0)
        }
        .injection(cycle: true) {
                    $0.interceptors.insert($1 as AuthInterceptor, at: 0)
        }
        .lifetime(.single)
        
        
//        // MARK: - Gateways
        self.container.register(RegistrationGatewayImp.init)
            .as(RegistrationGateway.self)
            .lifetime(.single)
        
        self.container.register(ApiAuthenticationGateway.init)
            .as(AuthenticationGateway.self)
            .lifetime(.single)
        
        self.container.register(PhotoGatewayImp.init)
            .as(PhotoGateway.self)
            .lifetime(.single)
        
        self.container.register(PostPhotoGatewayImp.init)
            .as(PostPhotoGateway.self)
            .lifetime(.single)
        
        self.container.register(UserGatewayImp.init)
            .as(UserGateway.self)
            .lifetime(.single)
//
//        // MARK: - UseCases
        self.container.register(RegistrationUsecaseImp.init)
            .as(RegistrationUsecase.self)
    
        self.container.register(LoginUsecaseImp.init)
            .as(LoginUsecase.self)
        
        self.container.register(ValidationUsecaseImp.init)
            .as(ValidationUsecase.self)
        
        self.container.register(PhotoUsecaseImp.init)
            .as(PhotoUsecase.self)
        
        self.container.register(PostPhotoUseCaseImp.init)
            .as(PostPhotoUseCase.self)
        
        self.container.register(UserUsecaseImp.init)
            .as(UserUsecase.self)
        
        self.container.register(UserDefaultsUsecaseImp.init)
            .as(UserDefaultsUsecase.self)
        
        // settings
        
        self.container.register(ProfileSettings.init)
            .as(Settings.self)
            .lifetime(.single)
        
    }
//     swiftlint:enable function_body_length

    static func resolve<T>() -> T {
        self.container.resolve()
    }
}
