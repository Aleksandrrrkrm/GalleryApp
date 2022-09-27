//
//  postPhotoGateway.swift
//  GalleryTest
//
//  Created by Александр Головин on 22.09.2022.
//

import Foundation
import RxNetworkApiClient
import RxSwift

protocol PostPhotoGateway {
    
    func postPhoto(_ file: UploadFile) -> Single<MediaFile>
    
    func postPhoto(_ photoEntity: PhotoPostEntity) -> Single<PhotoData>
}


final class PostPhotoGatewayImp: ApiBaseGateway, PostPhotoGateway {
    
    func postPhoto(_ file: UploadFile) -> Single<MediaFile>  {
        let request:ExtendedApiRequest<MediaFile> = .uploadFile(file)
        return apiClient.execute(request: request)
    }
    
    func postPhoto(_ photoEntity: PhotoPostEntity) -> Single<PhotoData> {
        apiClient.execute(request: ExtendedApiRequest.createFileByPath(photoEntity))
    }
}
