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
    private let userDefaultsUsecase: UserDefaultsUsecase
    private let userUsecase: UserUsecase

    
    //MARK: - Init
    init(_ view: AuthorizationSceneView,
         _ router: AuthorizationSceneRouter,
         _ authUseCase: LoginUsecase,
         _ userDefaultsUsecase: UserDefaultsUsecase,
         _ userUsecase: UserUsecase) {
        self.view = view
        self.router = router
        self.authUseCase = authUseCase
        self.userDefaultsUsecase = userDefaultsUsecase
        self.userUsecase = userUsecase
    }
    

    
    func loginUser(userName: String, password: String) {
        
        self.view?.errorLabel(hide: true)
        authUseCase.signUp(login: userName,
                           password: password)
            .observe(on: MainScheduler.instance)
            .subscribe { _ in
                
                self.router.openMainScene()
                self.getUserInfo()
            } onFailure: { error in
                HUD.flash(.error, delay: 0.7)
                self.view?.errorLabel(hide: false)
            }
            .disposed(by: disposeBag)
    }
    
    func getUserInfo() {
        
        userUsecase.getCurrentUser()
            .subscribe(
                onSuccess: { user in
                    
                    DispatchQueue.main.async {
                        guard let userName = user.username else {
                            return
                        }
                        guard let userId = user.id else {
                            return
                        }
                        self.userDefaultsUsecase.saveUserInfo(userName, userId)
                        
                    }
                }, onFailure: { error in
                    print(error)
                })
            .disposed(by: disposeBag)
        
    }
    
    
    func regButtonPressed() {
        router.openRegisterScene()
    }
    
}
