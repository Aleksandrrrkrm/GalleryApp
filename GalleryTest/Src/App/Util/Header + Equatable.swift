//
//  Header + Equatable.swift
//  GalleryTest
//
//  Created by Александр Головин on 14.09.2022.
//

import RxNetworkApiClient

extension Header: Equatable {

    public static func == (lhs: Header, rhs: Header) -> Bool {
        lhs.key == rhs.key &&
               lhs.value == rhs.value
    }
}

extension Dictionary: BodyConvertible where Key: Codable, Value: Codable {
}

extension Dictionary: JsonBodyConvertible where Key: Codable, Value: Codable {
}

