//
//  PhotoView.swift
//  GalleryTest
//
//  Created by Александр Головин on 01.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

protocol PhotoView {
    
    var imageView: UIImageView! { get set }
    var image: UIImage? { get set }
    var collectionView: UICollectionView! { get set }
}
