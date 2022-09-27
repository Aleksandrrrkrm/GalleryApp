//
//  WelcomePresenterImp.swift
//  GalleryTest
//
//  Created by Александр Головин on 25.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import UIKit

class WelcomePresenterImp: WelcomePresenter {
    
    var input: WelcomeView?
    
    private weak var view: WelcomeView?
    private let router: WelcomeRouter
    
    init(_ view: WelcomeView,
         _ router: WelcomeRouter) {
        self.view = view
        self.router = router
    }
    
    func registerButtonPressed() {
        router.openRegisterScene()
    }
    
    func authButtonPressed() {
        router.openAuthorizationScene()
    }
    
    
}


