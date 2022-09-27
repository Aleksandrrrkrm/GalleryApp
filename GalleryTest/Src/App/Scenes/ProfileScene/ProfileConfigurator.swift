//
//  ProfileConfigurator.swift
//  GalleryTest
//
//  Created by Александр Головин on 01.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

enum ProfileConfigurator {
    
    static func configure(view: ProfileViewController) {
        let router = ProfileRouter(view)
        let presenter = ProfilePresenterImp(view,
                                            router,
                                            DI.resolve(),
                                            DI.resolve())
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        guard let view = R.storyboard.profileStoryboard.instantiateInitialViewController() else {
            return
        }
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
