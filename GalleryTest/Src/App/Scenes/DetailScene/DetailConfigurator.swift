//
//  DetailConfigurator.swift
//  GalleryTest
//
//  Created by Александр Головин on 09.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

enum DetailConfigurator {
    
    static func configure(view: DetailViewController) {
        let router = DetailRouter(view)
        let presenter = DetailPresenterImp(view,
                                           router,
                                           DI.resolve())
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController,
                     photoString: String,
                     photo: UIImage,
                     description: String?,
                     photoUserName: String?) {
        guard let view = R.storyboard.detailStoryboard.instantiateInitialViewController() else {
            return
        }
        
        Self.configure(view: view)
        view.image = photo
        view.name = photoString
        view.descriptionPhoto = description
        view.userName = photoUserName
        navigationController.pushViewController(view,
                                                animated: true)
    }
}
