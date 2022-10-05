//
//  PhotoRouter.swift
//  GalleryTest
//
//  Created by Александр Головин on 01.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class PhotoRouter: BaseRouter {
    
    weak var view: UIViewController?
    
    init(_ view: PhotoViewController) {
        self.view = view
    }
    
    func openAddPhotoScene(image: UIImage) {
        guard let navController = self.view?.navigationController else {
            return
        }
        AddPhotoConfigurator.open(navigationController: navController,
                                  image: image)
    }
    
    func openMainScene() {
        guard let navController = self.view?.navigationController else {
            return
        }
        MainConfigurator.open(navigationController: navController)
    }
}
