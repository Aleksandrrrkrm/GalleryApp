//
//  TokenEntity.swift
//  GalleryTest
//
//  Created by Александр Головин on 29.08.2022.
//

import Foundation
import RxNetworkApiClient

public struct TokenEntity: Codable {
    
    enum CodingKeys: String, CodingKey {
           case accessToken = "access_token"
           case refreshToken = "refresh_token"
    }
    
    var accessToken: String
    var refreshToken: String
}


enum TokenCondition {
    case active
    case refreshing
    case failedRefreshing
    case notExists
}

