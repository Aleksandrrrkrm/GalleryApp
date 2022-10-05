//
//  AuthorizationSceneConfigurator.swift
//  GalleryTest
//
//  Created by Александр Головин on 25.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

enum AuthorizationSceneConfigurator {
    
    static func configure(view: AuthorizationSceneViewController) {
        let router = AuthorizationSceneRouter(view)
        let presenter = AuthorizationScenePresenterImp(view,
                                                       router,
                                                       DI.resolve(),
                                                       DI.resolve(),
                                                       DI.resolve())
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController) {
        guard let view = R.storyboard.authorizationSceneStoryboard.instantiateInitialViewController() else {
            return
        }
        var isRegVCAlreadyInStack = false
        
        for controller in navigationController.viewControllers {
            if controller is AuthorizationSceneViewController {
                isRegVCAlreadyInStack = true
            }
        }
        Self.configure(view: view)
        if isRegVCAlreadyInStack {
            navigationController.popViewController(animated: true)
        } else {
            navigationController.pushViewController(view,
                                                    animated: true)
        }
    }
}
