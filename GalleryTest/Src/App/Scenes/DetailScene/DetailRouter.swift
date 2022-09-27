//
//  DetailRouter.swift
//  GalleryTest
//
//  Created by Александр Головин on 09.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class DetailRouter: BaseRouter {
    
    weak var view: UIViewController?
    
    init(_ view: DetailViewController) {
        self.view = view
    }
    
    func openSomeScene(photo: UIImage) {
        guard let navController = self.view?.navigationController else {
            return
        }
        PhotoConfigurator.open(navigationController: navController, photo: photo)
    }
}
