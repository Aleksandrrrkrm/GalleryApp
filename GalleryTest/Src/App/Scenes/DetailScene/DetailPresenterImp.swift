//
//  DetailPresenterImp.swift
//  GalleryTest
//
//  Created by Александр Головин on 09.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import Kingfisher
import RxSwift
import RxNetworkApiClient


class DetailPresenterImp: DetailPresenter {
    
    private var view: DetailView?
    private let router: DetailRouter
    private let photoUsecase: PhotoUsecase
    private let disposeBag = DisposeBag()
    var photoUserName: String?
    
    init(_ view: DetailView,
         _ router: DetailRouter,
         _ photoUsecase: PhotoUsecase) {
        self.view = view
        self.router = router
        self.photoUsecase = photoUsecase
    }
    
    func getUserName(_ id: String) {
        photoUsecase.getUserName(id)
            .observe(on: MainScheduler.instance)
            .subscribe { user in
                self.view?.userNameLabel.text = user.username
            } onFailure: { error in
                print("@@@\(error.localizedDescription)")
            }
            .disposed(by: disposeBag)
    }
    
    func parsingDate(_ date: String) {

        let photoDate = date.split(separator: "T")
        var newDate = photoDate[0].split(separator: "-")
        newDate.reverse()
        newDate.insert(".", at: 2)
        newDate.insert(".", at: 1)
        let result = "\(newDate[0])\(newDate[1])\(newDate[2])\(newDate[3])\(newDate[4])"
        view?.dateLabel.text = result
    }
    
}
