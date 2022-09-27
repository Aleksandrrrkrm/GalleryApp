//
//  ProfilePresenterImp.swift
//  GalleryTest
//
//  Created by Александр Головин on 01.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import RxSwift
import RxNetworkApiClient


class ProfilePresenterImp: ProfilePresenter {
  
    
    
    private var view: ProfileView?
    private let router: ProfileRouter
    private let userUsecase: UserUsecase
    private let disposeBag = DisposeBag()
    private let photoUsecase: PhotoUsecase
    
    var arrayUserPhotoData: [PhotoData] = []
    
    init(_ view: ProfileView,
         _ router: ProfileRouter,
         _ userUsecase: UserUsecase,
         _ photoUsecase: PhotoUsecase) {
        self.view = view
        self.router = router
        self.userUsecase = userUsecase
        self.photoUsecase = photoUsecase
    }
    
    func currentUserInfo() {
        userUsecase.getCurrentUser()
            .subscribe(
                onSuccess: { user in
                    DispatchQueue.main.async {
                        self.view?.userNameLabel.text = user.username
                    }
                }, onFailure: {_ in
                })
            .disposed(by: disposeBag)
    }
    
    
    func getPhoto(idUser: Int) {
        
        let idString = String(idUser)
        photoUsecase.getUserPhoto(new: nil, popular: nil, page: 1, name: nil, id: idString)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onSuccess: {
                    guard let data = $0.data else {
                        return
                    }
                    for photo in data {
                        self.arrayUserPhotoData.append(photo)
                    }
                    print(self.arrayUserPhotoData.count)
                    self.view?.collectionUserView.reloadData()
                }, onFailure: {
                    print($0)
                })
            .disposed(by: disposeBag)
    }
    
    
    func openSettings() {
        
        router.openSomeScene()
    }
    
}
