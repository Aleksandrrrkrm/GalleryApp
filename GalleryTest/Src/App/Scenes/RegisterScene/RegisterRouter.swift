//
//  RegisterRouter.swift
//  GalleryTest
//
//  Created by Александр Головин on 24.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class RegisterRouter: BaseRouter {
    
    weak var view: UIViewController?
    
    init(_ view: RegisterViewController) {
        self.view = view
    }
    
    func openAuthScene() {
        guard let navController = self.view?.navigationController else {
            return
        }
          AuthorizationSceneConfigurator.open(navigationController: navController)
    }
    
    func clearNavStack() {
        guard let navController = self.view?.navigationController else {
            return
        }
        RegisterConfigurator.clear(navigationController: navController)
    }
    
    func openMainScene() {
        
        DispatchQueue.main.async {
            let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
            appDelegate?.openMainScreen(window: appDelegate?.window)
        }
        
    }
    
    
}
