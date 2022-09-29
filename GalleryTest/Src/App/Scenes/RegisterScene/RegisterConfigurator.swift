//
//  RegisterConfigurator.swift
//  GalleryTest
//
//  Created by Александр Головин on 24.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit
import Rswift

enum RegisterConfigurator {
    
    
    
    static func configure(view: RegisterViewController) {
        let router = RegisterRouter(view)
        let presenter = RegisterPresenterImp(view,
                                             router,
                                             DI.resolve(),
                                             DI.resolve(),
                                             DI.resolve())
        view.presenter = presenter
    }

    
    
    static func open(navigationController: UINavigationController) {
        guard let view = R.storyboard.registerStoryboard.instantiateInitialViewController() else {
            return
        }
        
        var isRegVCAlreadyInStack = false
        
        for controller in navigationController.viewControllers {
            if controller is RegisterViewController {
                isRegVCAlreadyInStack = true
            } 
        }
        
        Self.configure(view: view)
        
        if isRegVCAlreadyInStack {
            navigationController.popViewController(animated: true)
            print(isRegVCAlreadyInStack)
        } else {
            navigationController.pushViewController(view, animated: true)
            print(isRegVCAlreadyInStack)
        }
        
    }
    
    static func clear(navigationController: UINavigationController) {
        
        guard let view = R.storyboard.registerStoryboard.instantiateInitialViewController() else {
            return
        }
        Self.configure(view: view)
            
            navigationController.popViewController(animated: true)          
        }
    }
    
    

