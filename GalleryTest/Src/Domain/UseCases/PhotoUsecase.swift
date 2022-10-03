//
//  PhotoUsecase.swift
//  GalleryTest
//
//  Created by Александр Головин on 06.09.2022.
//

import Foundation
import RxSwift


protocol PhotoUsecase {
    
    func getPhoto(new: String?, popular: String?, page: Int, name: String?, id: String?) -> Single<PhotoModel>
    func getUserPhoto(new: String?, popular: String?, page: Int, name: String?, id: String?) -> Single<PhotoModel>
    func getUserName(_ id: String) -> Single<CurrentUser>
}

final class PhotoUsecaseImp: PhotoUsecase {
    
    private let photoGateway: PhotoGateway
    
    init (photoGateway: PhotoGateway) {
        self.photoGateway = photoGateway
    }
    
    func getPhoto(new: String?, popular: String?, page: Int, name: String?, id: String?) -> Single<PhotoModel> {
        photoGateway.getPhoto(new: new, popular: popular, page: page, name: name, id: id)
    }
    
    func getUserPhoto(new: String?, popular: String?, page: Int, name: String?, id: String?) -> Single<PhotoModel> {
        photoGateway.getPhoto(new: nil, popular: nil, page: page, name: name, id: id)
    }
    
    func getUserName(_ id: String) -> Single<CurrentUser> {
        photoGateway.getUser(id)
    }
    
}
