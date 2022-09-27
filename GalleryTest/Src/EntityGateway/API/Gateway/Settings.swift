//
//  Settings.swift
//  GalleryTest
//
//  Created by Александр Головин on 14.09.2022.
//

import Foundation

protocol AllUsersSettings {
    
    func getSimpleState() -> Bool
    func setSimpleState(_ state: Bool)
}

protocol Settings: AnyObject {
    
    var token: TokenEntity? { get set }
//    var account: UserEntity? { get set }
//    var accountsSuiteNames: [String]? { get set }
    func clearUserData()
}

class ProfileSettings: Settings {
    
    var token: TokenEntity? {
        get {
            guard let token = CustomUserDefaults.readToken() else {
                return nil
            }
            return token
        }
        set(newToken) {
            guard let token = newToken else {
                return
            }
            CustomUserDefaults.setToken(token)
            }
        }
    
    func clearUserData() {
        CustomUserDefaults.deleteToken()
    }
}

enum CustomUserDefaults {
    
    static func setToken(_ token: TokenEntity) {
        #if DEBUG
        print("token added!")
        #endif
        UserDefaults.standard.set(token.accessToken, forKey: "accessToken")
        UserDefaults.standard.set(token.refreshToken, forKey: "refreshToken")
        UserDefaults.standard.synchronize()
    }
    
    static func readToken() -> TokenEntity? {
        let accessToken = UserDefaults.standard.string(forKey: "accessToken")
        let refreshToken = UserDefaults.standard.string(forKey: "refreshToken")
        if let accessT = accessToken,
           let refreshT = refreshToken {
            let token = TokenEntity(accessToken: accessT, refreshToken: refreshT)
            return token
        } else {
            return nil
        }
    }
    
    static func deleteToken() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        UserDefaults.standard.synchronize()
    }
}
