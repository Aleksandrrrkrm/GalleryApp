//
//  MainConfigurator.swift
//  GalleryTest
//
//  Created by Александр Головин on 29.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit


enum MainConfigurator {
    
    static func configure(view: MainViewController) {
        let router = MainRouter(view)
        let presenter = MainPresenterImp(view,
                                         router,
                                         DI.resolve())
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        guard let view = R.storyboard.mainStoryboard.instantiateInitialViewController() else {
            return
        }
        Self.configure(view: view)
//        navigationController.pushViewController(view,
//                                                animated: true)
        view.present(view, animated: true)
    }
}
