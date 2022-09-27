//
//  PostPhotoUseCase.swift
//  GalleryTest
//
//  Created by Александр Головин on 22.09.2022.
//

import Foundation
import RxNetworkApiClient
import RxSwift


protocol PostPhotoUseCase {
    
    
    func postMediaObject(_ file: UploadFile) -> Single<MediaFile>
    
    func postPhoto(_ photoEntity: PhotoPostEntity) -> Single<PhotoData>
}


final class PostPhotoUseCaseImp: PostPhotoUseCase {
    
    
    private let postPhotoGateway: PostPhotoGateway
    
    
    init (postPhotoGateway: PostPhotoGateway) {
        
        self.postPhotoGateway = postPhotoGateway
    }
    
    
    func postMediaObject(_ file: UploadFile) -> Single<MediaFile> {
        
        postPhotoGateway.postPhoto(file)
    }

    func postPhoto(_ photoEntity: PhotoPostEntity) -> Single<PhotoData> {
        
        postPhotoGateway.postPhoto(photoEntity)
        
    }
    
}
