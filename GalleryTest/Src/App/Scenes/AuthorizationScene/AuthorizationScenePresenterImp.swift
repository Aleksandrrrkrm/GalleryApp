//
//  AuthorizationScenePresenterImp.swift
//  GalleryTest
//
//  Created by Александр Головин on 25.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import RxSwift
import RxNetworkApiClient
import PKHUD


class AuthorizationScenePresenterImp: AuthorizationScenePresenter {
    
    private let disposeBag = DisposeBag()
    private let authUseCase: LoginUsecase
    private weak var view: AuthorizationSceneView?
    private let router: AuthorizationSceneRouter
    
    //MARK: - Init
    init(_ view: AuthorizationSceneView,
         _ router: AuthorizationSceneRouter,
         _ authUseCase: LoginUsecase) {
        self.view = view
        self.router = router
        self.authUseCase = authUseCase
    }
    

    
    func loginUser(userName: String, password: String) {
        
        self.view?.errorLabel(hide: true)
        authUseCase.signUp(login: userName, password: password)
            .observe(on: MainScheduler.instance)
            .subscribe { _ in
                
                self.router.openMainScene()
            } onFailure: { error in
                HUD.flash(.error, delay: 0.7)
                self.view?.errorLabel(hide: false)
            }
            .disposed(by: disposeBag)
    }
    
    
    
    
    func regButtonPressed() {
        router.openRegisterScene()
    }
    
}
