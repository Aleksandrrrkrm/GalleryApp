//
//  WelcomeRouter.swift
//  GalleryTest
//
//  Created by Александр Головин on 25.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class WelcomeRouter: BaseRouter {
    
    weak var view: UIViewController?
    
    init(_ view: UIViewController) {
        self.view = view
    }
    
    func openRegisterScene() {
        guard let navController = self.view?.navigationController else {
            return
        }
          RegisterConfigurator.open(navigationController: navController)
    }
    
    func openAuthorizationScene() {
        guard let navController = self.view?.navigationController else {
            return
        }
          AuthorizationSceneConfigurator.open(navigationController: navController)
    }    
}
