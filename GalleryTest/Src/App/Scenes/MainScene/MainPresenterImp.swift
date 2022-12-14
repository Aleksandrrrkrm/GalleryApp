//
//  MainPresenterImp.swift
//  GalleryTest
//
//  Created by Александр Головин on 29.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import RxSwift
import RxNetworkApiClient
import CoreMedia

class MainPresenterImp: MainPresenter {
    
    private var view: MainView?
    private let router: MainRouter
    private let photoUsecase: PhotoUsecase
    
    // Helpers
    var photoUserName: String?
    var currentPage = 1
    var totalItems: Int?
    private var isPopular: Bool?
    
    private let disposeBag = DisposeBag()
    
    var arrayPhotoData: [PhotoData] = []
    
    init(_ view: MainView,
         _ router: MainRouter,
         _ photoUsecase: PhotoUsecase) {
        self.view = view
        self.router = router
        self.photoUsecase = photoUsecase
    }
    
    
    //MARK: - USAGE
    func getPhoto(isNew: Bool?, for search: String?) {
        if arrayPhotoData.count < 1 {
        view?.startTimer()
        }
        let new = isNew ?? false ? R.string.scenes.false() : R.string.scenes.true()
        let popular = isNew ?? true ? R.string.scenes.true() : R.string.scenes.false()
        
        photoUsecase.getPhoto(new: new,
                              popular: popular,
                              page: currentPage,
                              name: search,
                              id: nil)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onSuccess: {
                    self.view?.stopTimer()
                    self.totalItems = $0.totalItems
                    guard let data = $0.data else {
                        return
                    }
                    for photo in data {
                        self.arrayPhotoData.append(photo)
                    }
                    self.currentPage += 1
                    self.view?.collectionView.reloadData()
                }, onFailure: { error in
                    
                    // TODO:  модалка с локалйзед дескрипшен
                    print(error.localizedDescription)
                })
            .disposed(by: disposeBag)
    }
    

    
    func openDetailScene(data: PhotoData?,
                         photo: UIImage) {
        router.openSomeScene(data: data,
                             photo: photo)
        
    }
    
    func resetCollectionData() {
        arrayPhotoData = []
        currentPage = 1
    }
    
}
