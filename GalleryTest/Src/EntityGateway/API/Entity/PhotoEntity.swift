//
//  PhotoEntity.swift
//  GalleryTest
//
//  Created by Александр Головин on 06.09.2022.
//

import Foundation


struct PhotoModel: Codable {
    
    var totalItems: Int?
    var itemsPerPage: Int?
    var countOfPages: Int?
    var data: [PhotoData]?
    
}

struct PhotoData: Codable {
    
    var name: String?
    var dateCreate: String?
    var description: String?
    var new: Bool?
    var popular: Bool?
    var user: String?
    var id: Int?
    var image: Image?
    
}

struct Image: Codable {
    
    var id: Int
    var name: String
    
}
