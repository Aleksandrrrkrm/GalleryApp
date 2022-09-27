//
//  AuthorizationScenePresenter.swift
//  GalleryTest
//
//  Created by Александр Головин on 25.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation

protocol AuthorizationScenePresenter {
    
    
    func loginUser(userName: String, password: String)
    
    func regButtonPressed()
}
