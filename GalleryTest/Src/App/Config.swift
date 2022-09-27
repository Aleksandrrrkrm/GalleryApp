//
//  Config.swift
//  GalleryTest
//
//  Created by Александр Головин on 26.08.2022.
//

import Foundation
import RxNetworkApiClient

enum Config {
    
    static var apiEndpoint = R.string.scenes.apiEndpoint()
    
    static var clientId = R.string.scenes.clientId()

    static var clientSecret = R.string.scenes.secretId()
    
    static var extraPath = R.string.scenes.emptyLine()
}

