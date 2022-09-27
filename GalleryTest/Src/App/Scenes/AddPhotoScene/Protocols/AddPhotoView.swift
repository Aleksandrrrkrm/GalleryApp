//
//  AddPhotoView.swift
//  GalleryTest
//
//  Created by Александр Головин on 21.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

protocol AddPhotoView {
    
    func errorAlert(_ title: String?, message: String?)
    
    func startTimer()
    func stopTimer()
}
