//
//  PhotoConfigurator.swift
//  GalleryTest
//
//  Created by Александр Головин on 01.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

enum PhotoConfigurator {
    
    
    static func configure(view: PhotoViewController) {
        let router = PhotoRouter(view)
        let presenter = PhotoPresenterImp(view,
                                          router)
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController,
                     photo: UIImage) {
        guard let view = R.storyboard.photoStoryboard.instantiateInitialViewController() else {
            return
        }
        Self.configure(view: view)
        navigationController.pushViewController(view,
                                                animated: true)
        view.image = photo
    }
    
    
    static func openWihtPhoto(photo: UIImage) {
        guard let view = R.storyboard.photoStoryboard.instantiateInitialViewController() else {
            return
        }
        Self.configure(view: view)
        view.imageView.image = photo
    }
}
