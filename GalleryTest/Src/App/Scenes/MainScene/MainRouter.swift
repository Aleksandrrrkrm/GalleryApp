//
//  MainRouter.swift
//  GalleryTest
//
//  Created by Александр Головин on 29.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class MainRouter: BaseRouter {
    
    weak var view: UIViewController?
    init(_ view: MainViewController) {
        self.view = view
    }
    
    func openSomeScene(data: PhotoData?,
                       photo: UIImage) {
        guard let navController = self.view?.navigationController else {
            return
        }
        DetailConfigurator.open(navigationController: navController,
                                data: data,
                                photo: photo)
    }
}
