//
//  MainPresenter.swift
//  GalleryTest
//
//  Created by Александр Головин on 29.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import UIKit

protocol MainPresenter {
    
    func openDetailScene(photoName: String, photo: UIImage, description: String?, photoUserName: String?)
   
    func getPhoto(isNew: Bool?, for search: String?)
    
    var arrayPhotoData: [PhotoData] { get set }
    
    var currentPage: Int { get set }
    
    var totalItems: Int? { get set }
    
    func resetCollectionData()
}
