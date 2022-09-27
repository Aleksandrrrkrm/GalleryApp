//
//  JsonContentInterceptor.swift
//  GalleryTest
//
//  Created by Александр Головин on 14.09.2022.
//

import Foundation
import RxNetworkApiClient

class JsonContentInterceptor: Interceptor {

    func prepare<T: Codable>(request: ApiRequest<T>) {
        var headers = request.headers ?? [Header]()

        if !headers.contains(.acceptJson) {
            headers.append(.acceptJson)
            request.headers = headers
        }
    }

    func handle<T: Codable>(request: ApiRequest<T>, response: NetworkResponse) {
        // Noting to do.
    }
}

class ExtraPathInterceptor: Interceptor {
    
    func prepare<T: Codable>(request: ApiRequest<T>) {

        if request.path?.contains("oauth") ?? false &&
            request.path?.contains("uploads") ?? false &&
            request.path?.contains("/api") ?? false &&
            request.path?.contains("/lookup") ?? false {
        }
    }

    func handle<T: Codable>(request: ApiRequest<T>, response: NetworkResponse) {
        // Noting to do.
    }
}
