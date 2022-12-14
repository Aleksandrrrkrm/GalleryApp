//
//  DetailView.swift
//  GalleryTest
//
//  Created by Александр Головин on 09.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

protocol DetailView {
    var dateLabel: UILabel! { get set }
    var image: UIImage? { get set }
    var name: String? { get set }
    var descriptionPhoto: String? { get set }
    var userNameLabel: UILabel! { get set }
    var userName: String? { get set }
    var photoDate: String? { get set }
}
