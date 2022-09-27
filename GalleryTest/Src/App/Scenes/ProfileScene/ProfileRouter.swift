//
//  ProfileRouter.swift
//  GalleryTest
//
//  Created by Александр Головин on 01.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class ProfileRouter: BaseRouter {
    
    weak var view: UIViewController?
    
    init(_ view: ProfileViewController) {
        self.view = view
    }
    
    func openSomeScene() {
        guard let navController = self.view?.navigationController else {
            return
        }
        SettingsConfigurator.open(navigationController: navController)
    }
}
