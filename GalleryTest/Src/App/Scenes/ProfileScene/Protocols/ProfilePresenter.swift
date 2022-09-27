//
//  ProfilePresenter.swift
//  GalleryTest
//
//  Created by Александр Головин on 01.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import UIKit

protocol ProfilePresenter {
    
    func currentUserInfo()
    func getPhoto(idUser: Int)
    var arrayUserPhotoData: [PhotoData] { get set }
    func openSettings()
}
