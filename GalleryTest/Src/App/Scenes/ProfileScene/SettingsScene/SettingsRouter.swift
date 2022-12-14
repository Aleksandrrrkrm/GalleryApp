//
//  SettingsRouter.swift
//  GalleryTest
//
//  Created by Александр Головин on 23.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class SettingsRouter: BaseRouter {
    
    weak var view: UIViewController?
    
    init(_ view: SettingsViewController) {
        self.view = view
    }
    
    func openSomeScene() {
        guard let navController = self.view?.navigationController else {
            return
        }
          WelcomeConfigurator.open(navigationController: navController)
    }
}
