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

//    private func parsing(_ str: String, _ inputArray: inout String) {
//        var index = 0
//        while !str[str.index(str.startIndex, offsetBy: index)].isNumber && (index < str.count) {
//            inputArray.append(0)
//            index += 1
//        }
//        let nums = str.split(separator: ".")
//        for substr in nums {
//            inputArray.append(substr!)
//        }
//    }
    
    static func open(navigationController: UINavigationController,
                     data: PhotoData?,
                     photo: UIImage) {
        guard let view = R.storyboard.detailStoryboard.instantiateInitialViewController() else {
            return
        }

        Self.configure(view: view)
        view.image = photo
        view.name = data?.name
        view.descriptionPhoto = data?.description
        view.userName = data?.user
        view.photoDate = data?.dateCreate
        navigationController.pushViewController(view,
                                                animated: true)
    }
}
