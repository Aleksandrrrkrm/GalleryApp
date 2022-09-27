//
//  MainView.swift
//  GalleryTest
//
//  Created by Александр Головин on 29.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

protocol MainView {
    
    var collectionView: UICollectionView! { get }
    
    func startTimer()
    func stopTimer()
}
