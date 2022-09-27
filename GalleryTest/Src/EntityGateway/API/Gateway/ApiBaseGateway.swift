//
//  ApiBaseGateway.swift
//  GalleryTest
//
//  Created by Александр Головин on 13.09.2022.
//

import Foundation
import RxNetworkApiClient

class ApiBaseGateway {

    let apiClient: ApiClient

    init(_ apiClient: ApiClient) {
        self.apiClient = apiClient
    }
}
