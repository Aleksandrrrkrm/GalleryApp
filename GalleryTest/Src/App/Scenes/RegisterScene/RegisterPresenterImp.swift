//
//  RegisterPresenterImp.swift
//  GalleryTest
//
//  Created by Александр Головин on 24.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import RxSwift
import RxNetworkApiClient
import PKHUD

class RegisterPresenterImp: RegisterPresenter {
    
    
    
    private weak var view: RegisterView?
    private let router: RegisterRouter
    private let loginUsecase: LoginUsecase
    private let disposeBag = DisposeBag()
    private let validationUsecase: ValidationUsecase
    private let registrationUsecase: RegistrationUsecase
    
    
    
    init(_ view: RegisterView,
         _ router: RegisterRouter,
         _ registrationUsecase: RegistrationUsecase,
         _ loginUsecase: LoginUsecase,
         _ validationUsecase: ValidationUsecase) {
        self.view = view
        self.router = router
        self.registrationUsecase = registrationUsecase
        self.loginUsecase = loginUsecase
        self.validationUsecase = validationUsecase
    }
    
    func registerUser(data: RegistrationEntity) {
        registrationUsecase.signUp(user: data)
            .andThen(loginUsecase.signUp(login: data.username,
                                         password: data.password))
            .observe(on: MainScheduler.instance)
            .subscribe { _ in
                HUD.flash(.success, delay: 0.3)
                self.router.openMainScene()
            } onFailure: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
    
    
    func authButtonPressed() {
        router.openAuthScene()
    }
    
    
    func validateUserName(userName: String) -> String? {
            do {
                try validationUsecase.validationUserName(userName: userName)
            } catch ErrorValidate.invalidSymbol {
                return R.string.errors.userNameInvalidSymbol()
            } catch {
                return error.localizedDescription
            }
            return nil
    }
    
    func validateEmail(email: String) -> String? {
            do {
                try validationUsecase.validationEmail(email: email)
            } catch ErrorValidate.invalidEmail {
                return R.string.errors.invalidEmail()
            } catch {
                return error.localizedDescription
            }
            return nil
    }
    
    func validatePassword(password: String) -> String? {
            do {
                try validationUsecase.validationPassword(password: password)
            } catch ErrorValidate.lengthPassword {
                return R.string.errors.lengthPassword()
            } catch {
                return error.localizedDescription
            }
            return nil
    }
    
    func validateConfirmPassword(password: String, confirmPassword: String) -> String? {
            do {
                try validationUsecase.validationConfirmPassword(password: password, confirmPassword: confirmPassword)
            } catch ErrorValidate.passwordWrong {
                return R.string.errors.wrongPassword()
            } catch {
                return error.localizedDescription
            }
            return nil
    }
    
}
