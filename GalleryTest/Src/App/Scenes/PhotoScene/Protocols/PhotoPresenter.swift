//
//  PhotoPresenter.swift
//  GalleryTest
//
//  Created by Александр Головин on 01.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import SnapKit
import Photos
import PhotosUI

protocol PhotoPresenter {
    
    func getImages()
    var allImages: [UIImage] { get set }
    var countOfPhoto: Int { get set }
    func addPhoto(image: UIImage)
}
