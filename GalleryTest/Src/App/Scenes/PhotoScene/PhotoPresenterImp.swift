//
//  PhotoPresenterImp.swift
//  GalleryTest
//
//  Created by Александр Головин on 01.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import UIKit
import Photos
import PhotosUI

class PhotoPresenterImp: PhotoPresenter {
   
    
   
    
    var description: String?
    var imagePicker = UIImagePickerController()
    
    private var view: PhotoView?
    private let router: PhotoRouter?
    
    private let requestOptions = PHImageRequestOptions()
    private var result = PHAsset()
    private var allPhotos = PHFetchResult<PHAsset>()
    private var smartAlbums = PHFetchResult<PHAssetCollection>()
    private var userCollections = PHFetchResult<PHAssetCollection>()
    private var currentIndex = 0
    internal var countOfPhoto = 0
       
    
    var allImages: [UIImage] = []
    
    init(_ view: PhotoView,
         _ router: PhotoRouter) {
        self.view = view
        self.router = router
    }
    
    func addPhoto(image: UIImage) {
        router?.openAddPhotoScene(image: image)
    }
    
    func getImages() {
        
        requestOptions.deliveryMode = .highQualityFormat
        requestOptions.isSynchronous = true
        
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [
            NSSortDescriptor(
                key: R.string.scenes.creationDate(),
                ascending: false)
        ]
      
        allPhotos = PHAsset.fetchAssets(with: .image, options: allPhotosOptions)
       
        smartAlbums = PHAssetCollection.fetchAssetCollections(
            with: .smartAlbum,
            subtype: .albumRegular,
            options: nil)
        
        userCollections = PHAssetCollection.fetchAssetCollections(
            with: .album,
            subtype: .albumRegular,
            options: nil)
        if allPhotos.count > 20 {
            countOfPhoto = 20
        } else {
            countOfPhoto = allPhotos.count
        }
        
        
       
        for photo in 0..<countOfPhoto {
            let firstAsset = allPhotos[photo]
            
            PHImageManager.default().requestImage(
                for: firstAsset,
                targetSize: CGSize(width: 300, height: 300),
                contentMode: .aspectFill,
                options: requestOptions)  { (image, _) -> Void in
                    self.allImages.append(image!)
                }
            view?.collectionView.reloadData()
        }
    }
    
}
