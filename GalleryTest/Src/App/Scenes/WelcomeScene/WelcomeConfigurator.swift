//
//  WelcomeConfigurator.swift
//  GalleryTest
//
//  Created by Александр Головин on 25.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit
import Rswift


enum WelcomeConfigurator {
    
    static func configure(view: WelcomeViewController) {
        let router = WelcomeRouter(view)
        let presenter = WelcomePresenterImp(view, router)
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController) {
        guard let view = R.storyboard.welcomeStoryboard.instantiateInitialViewController() else {
            return
        }
        
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.pushViewController(navigationController, animated: true)
    }
}
