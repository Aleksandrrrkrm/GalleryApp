//
//  AuthorizationSceneRouter.swift
//  GalleryTest
//
//  Created by Александр Головин on 25.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class AuthorizationSceneRouter: BaseRouter {
    
    weak var view: UIViewController?
    
    init(_ view: UIViewController) {
        self.view = view
    }
    
    func openMainScene() {
        DispatchQueue.main.async {
            let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
            appDelegate?.openMainScreen(window: appDelegate?.window)
        }
    }
    
    func openRegisterScene() {
        guard let navController = self.view?.navigationController else {
            return
        }
          RegisterConfigurator.open(navigationController: navController)
    }
    
}
