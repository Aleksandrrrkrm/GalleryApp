//
//  DetailPresenterImp.swift
//  GalleryTest
//
//  Created by Александр Головин on 09.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import Kingfisher


class DetailPresenterImp: DetailPresenter {
    
    private var view: DetailView?
    private let router: DetailRouter
    
    init(_ view: DetailView,
         _ router: DetailRouter) {
        self.view = view
        self.router = router
    }
    

    
    
}
