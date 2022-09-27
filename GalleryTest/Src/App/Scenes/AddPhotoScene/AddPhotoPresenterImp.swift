//
//  AddPhotoPresenterImp.swift
//  GalleryTest
//
//  Created by Александр Головин on 21.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import RxNetworkApiClient
import RxSwift
import PKHUD

class AddPhotoPresenterImp: AddPhotoPresenter {
    
    private var view: AddPhotoView?
    private let router: AddPhotoRouter
    
    private let postPhotoUseCase: PostPhotoUseCase
    private let disposeBag = DisposeBag()
    
    init(_ view: AddPhotoView,
         _ router: AddPhotoRouter,
         _ postPhotoUseCase: PostPhotoUseCase) {
        self.view = view
        self.router = router
        self.postPhotoUseCase = postPhotoUseCase
    }
    
    
    
    func addDataButtonPressed(_ image: UIImage, _ photo: PhotoPostEntity) {
        guard let data = image.jpegData(compressionQuality: 0.1) else {
            return
        }
        let file = UploadFile("file", data, "image")
        postPhotoUseCase.postMediaObject(file)
            .do(onSubscribe: { [weak self] in
                
            })
            .flatMap({ [weak self] mediaFile -> Single<PhotoData> in
                guard let strongSelf = self else {
                    return Single.create { observer in
                        
                        
                        return Disposables.create()
                    }
                }
                let newPhoto = PhotoPostEntity(name: photo.name,
                                               description: photo.description,
                                               image: mediaFile.id)
                return strongSelf.postPhotoUseCase.postPhoto(newPhoto)
            })
                .observe(on: MainScheduler.instance)
                .subscribe(onSuccess: {[weak self] photoEntity in
                    HUD.flash(.success, delay: 0.3)
                    self?.router.clearNavStack()
                    self?.router.openSomeScene(photoString: photoEntity.name!, photo: image , description: nil)
                    self?.view?.stopTimer()
                }, onFailure: { error in
                    self.view?.stopTimer()
                    self.view?.errorAlert(R.string.scenes.someThingWrong(), message: R.string.scenes.recomendationInternet())
#if DEBUG
                    print("@@@@ error:\(error)")
#endif
                })
                .disposed(by: self.disposeBag)
                
                }
    

}





