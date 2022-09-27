//
//  ApiEndpoint.swift
//  GalleryTest
//
//  Created by Александр Головин on 26.08.2022.
//

import Foundation
import RxNetworkApiClient

extension ApiEndpoint {

    private(set) static var webAntDevApi = ApiEndpoint(Config.apiEndpoint)

    static func updateEndpoint() {
        ApiEndpoint.webAntDevApi = ApiEndpoint(Config.apiEndpoint)
    }
}
