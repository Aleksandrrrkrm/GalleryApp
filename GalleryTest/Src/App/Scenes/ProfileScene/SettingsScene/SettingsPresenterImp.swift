//
//  SettingsPresenterImp.swift
//  GalleryTest
//
//  Created by Александр Головин on 23.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import RxSwift
import RxNetworkApiClient

class SettingsPresenterImp: SettingsPresenter {
    
    private var view: SettingsView?
    private let router: SettingsRouter
    private let disposeBag = DisposeBag()
    private let userUsecase: UserUsecase
    var window: UIWindow?
    
    init(_ view: SettingsView,
         _ router: SettingsRouter,
         _ userUsecase: UserUsecase) {
        self.view = view
        self.router = router
        self.userUsecase = userUsecase
    }
    
    func currentUserInfo() {
        userUsecase.getCurrentUser()
            .subscribe(
                onSuccess: { user in
                    DispatchQueue.main.async {
                        self.view?.nameTextField.text = user.username
                        self.view?.emailTextField.text = user.email
                    }
                    
                }, onFailure: {_ in
                    
                })
            .disposed(by: disposeBag)
    }
    
    func openStartScreen() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        (UIApplication.shared.delegate as? AppDelegate)?.openStartScreen(window: self.window)
    }
}
