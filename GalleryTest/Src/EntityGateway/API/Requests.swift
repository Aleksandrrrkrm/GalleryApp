//
//  Requests.swift
//  GalleryTest
//
//  Created by Александр Головин on 26.08.2022.
//

import Foundation
import RxNetworkApiClient
import RxSwift

// swiftlint:disable file_length superfluous_disable_command

extension ExtendedApiRequest {

    // Важно поменять структуру запросов в соответствии с Api проекта
    
    // MARK: /oauth
    
    static func loginRequest(_ login: String, _ password: String) -> ExtendedApiRequest {
        
        
//        let appVersion = Bundle.main.shortVersion

        return extendedRequest(path: "/oauth/v2/token",
                               method: .get,
                               query: ("client_id", Config.clientId),
                               ("client_secret", Config.clientSecret),
                               ("grant_type", "password"),
                               ("username", login),
                               ("password", password))
    }
    
    
    static func getPhotoRequest(_ isPopular: String?, _ isNew: String?, _ page: Int, _ name: String?, _ userId: String?) -> ExtendedApiRequest {
        return extendedRequest(path: "/api/photos?",
                               method: .get,
                               query: ("new", isNew),
                               ("popular", isPopular),
                               ("page", "\(page)"),
                               ("limit", "10"),
                               ("name", name),
                               ("user.id", userId))
    }
    


    static func refreshToken(_ refreshToken: String) -> ExtendedApiRequest {
             extendedRequest(
                path: "/oauth/v2/token",
                method: .post,
                formData: [
                "client_id": Config.clientId,
                "grant_type": "refresh_token",
                "refresh_token": refreshToken,
                "client_secret": Config.clientSecret
                ]
             )
        }
    
    static func signUp(_ entity: RegistrationEntity) -> ExtendedApiRequest {
        extendedRequest(path: "/api/users",
                        method: .post,
                        headers: [Header.contentJson],
                        body: entity)
    }
//
//    static func signUP(_ entity: SignUpEntity, _ locale: String) -> ExtendedApiRequest {
//        extendedRequest(path: "/users",
//                        method: .post,
//                        headers: [Header.contentJson, Header("localization", locale)],
//                        body: entity,
//                        query: ("lang", locale))
//    }
//
//    static func checkEmail(_ entity: CheckUserEntity) -> ExtendedApiRequest {
//        extendedRequest(path: "/users/check-email",
//                        method: .patch,
//                        headers: [Header.contentJson],
//                        body: entity)
//    }
//
//    static func checkPhone(_ entity: CheckUserEntity) -> ExtendedApiRequest {
//        extendedRequest(path: "/users/check-phone",
//                        method: .patch,
//                        headers: [Header.contentJson],
//                        body: entity)
//    }
//
//    // MARK: - Devices
//
//    static func registerDevice(_ deviceId: String) -> ExtendedApiRequest {
//        let body = ApiDeviceEntity(deviceId: deviceId)
//
//        return extendedRequest(path: "/devices",
//                               method: .post,
//                               headers: [Header.contentJson],
//                               body: body)
//    }
//
//    // MARK: - UserInfo

    static func getAccountRequest() -> ExtendedApiRequest {
        extendedRequest(path: "/api/users/current",
                        method: .get,
                        headers: [Header.contentJson])
    }

//    static func updateUserInfo(_ userId: Int, _ user: UserEditingEntity) -> ExtendedApiRequest {
//        extendedRequest(path: "/users/\(userId)",
//                        method: .put,
//                        headers: [Header.contentJson],
//                        body: user)
//    }
//
//    // Изменение пароля при восстановлении
//    static func updatePasswordAfterRecovery(_ userId: Int, _ entity: ChangePasswordEntity) -> ExtendedApiRequest {
//        extendedRequest(path: "/users/\(userId)/change/lost-password",
//                        method: .put,
//                        headers: [Header.contentJson],
//                        body: entity)
//    }
//
//    // Изменение пароля
//    static func updatePassword(_ userId: Int, _ entity: ChangePasswordEntity) -> ExtendedApiRequest {
//        extendedRequest(path: "/users/\(userId)/change/password",
//                        method: .put,
//                        headers: [Header.contentJson],
//                        body: entity)
//    }
//
//    // Изменение телефона
//    static func updatePhone(_ userId: Int, _ entity: CodeVerificationEntity) -> ExtendedApiRequest {
//        extendedRequest(path: "/users/\(userId)/change/phone",
//                        method: .put,
//                        headers: [Header.contentJson],
//                        body: entity)
//    }
//
//    static func checkUserInfo(_ entity: CheckUserEntity) -> ExtendedApiRequest {
//        extendedRequest(path: "/users/check_user",
//                        method: .post,
//                        headers: [Header.contentJson],
//                        body: entity)
//    }
//
//    // MARK: - Version
//
//    static func getVersion() -> ExtendedApiRequest {
//        extendedRequest(path: "/app_version",
//                        method: .get)
//    }
//
//    // MARK: - File

    static func uploadFile(_ file: UploadFile) -> ExtendedApiRequest {
        extendedRequest(path: "/api/media_objects",
                        method: .post,
                        files: [file])
    }

    static func createFileByPath(_ file: PhotoPostEntity) -> ExtendedApiRequest {
        extendedRequest(path: "/api/photos",
                        method: .post,
                        headers: [Header.contentJson],
                        body: file)
    }
//
//    // MARK: - VerificationCode
//
//    static func confirmCode(_ changePasswordEntity: CodeVerificationEntity) -> ExtendedApiRequest {
//        extendedRequest(path: "/confirm-code",
//                        method: .post,
//                        headers: [Header.contentJson],
//                        body: changePasswordEntity)
//    }
//
//    // Инициация сброса пароля
//    static func resetPassword(_ changePasswordEntity: CodeVerificationEntity) -> ExtendedApiRequest {
//        extendedRequest(path: "/password/reset",
//                        method: .post,
//                        headers: [Header.contentJson],
//                        body: changePasswordEntity)
//    }
//
//    static func resendActivationCode(_ changePasswordEntity: CodeVerificationEntity) -> ExtendedApiRequest {
//        extendedRequest(path: "/resend-activation-code",
//                        method: .post,
//                        headers: [Header.contentJson],
//                        body: changePasswordEntity)
//    }
}

