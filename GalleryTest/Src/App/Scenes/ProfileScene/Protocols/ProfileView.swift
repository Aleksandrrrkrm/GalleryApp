//
//  ProfileView.swift
//  GalleryTest
//
//  Created by Александр Головин on 01.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

protocol ProfileView {    
    var userNameLabel: UILabel! { get set }
    var collectionUserView: UICollectionView! { get }
    var userPhotosCount: UILabel! { get set }
}
