//
//  AddPhotoConfigurator.swift
//  GalleryTest
//
//  Created by Александр Головин on 21.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

enum AddPhotoConfigurator {
    
    static func configure(view: AddPhotoViewController) {
        let router = AddPhotoRouter(view)
        let presenter = AddPhotoPresenterImp(view,
                                             router,
                                             DI.resolve())
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController, image: UIImage) {
        let view = AddPhotoViewController()
        view.imageView.image = image
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
