//
//  PhotoGateway.swift
//  GalleryTest
//
//  Created by Александр Головин on 06.09.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol PhotoGateway {
    
    
    func getPhoto(new: String?, popular: String?, page: Int, name: String?, id: String?) -> Single<PhotoModel>
    
    
}

final class PhotoGatewayImp: ApiBaseGateway, PhotoGateway {

    func getPhoto(new: String?, popular: String?, page: Int, name: String?, id: String?) -> Single<PhotoModel> {
        let request:ExtendedApiRequest<PhotoModel> = .getPhotoRequest(new, popular, page, name, id)
        return apiClient.execute(request: request)
    }
    
    
}
