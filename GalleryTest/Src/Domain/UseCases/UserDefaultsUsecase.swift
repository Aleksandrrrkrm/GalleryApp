//
//  UserDefaultsUsecase.swift
//  GalleryTest
//
//  Created by Александр Головин on 29.09.2022.
//

import Foundation
import RxNetworkApiClient
import RxSwift


protocol UserDefaultsUsecase {
    
    func saveUserInfo(_ name: String, _ id: Int)
}

final class UserDefaultsUsecaseImp: UserDefaultsUsecase {
 
    func saveUserInfo(_ name: String, _ id: Int) {
        
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "userName")
        defaults.set(id, forKey: "userId")
    }
    
}
