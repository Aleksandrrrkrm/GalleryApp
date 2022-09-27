//
//  PhotoPostEntity.swift
//  GalleryTest
//
//  Created by Александр Головин on 22.09.2022.
//

import Foundation
import RxNetworkApiClient


struct PhotoPostEntity: Codable, JsonBodyConvertible {
    var name: String?
    var description: String?
    var image: String?
    var new: Bool?
    var popular: Bool?
    
    init (name: String?,
          description: String?,
          image: Int?) {
        self.name = name
        self.description = description
        self.image = "/api/media_objects/\(image ?? 0)"
        self.popular = Bool.random()
        self.new = !(self.popular ?? true)
    }
}


struct MediaFile: Codable, JsonBodyConvertible {
    
    var id: Int?
    var name: String?
}
