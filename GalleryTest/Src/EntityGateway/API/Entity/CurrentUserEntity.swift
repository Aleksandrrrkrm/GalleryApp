//
//  CurrentUserEntity.swift
//  GalleryTest
//
//  Created by Александр Головин on 23.09.2022.
//

import Foundation
import RxNetworkApiClient

struct CurrentUser: Codable, JsonBodyConvertible {
    
    let id: Int?
    let email: String?
    let phone: String?
    let username: String?
    let birthday: String?
}
