//
//  ReuseStrings.swift
//  GalleryTest
//
//  Created by Александр Головин on 26.09.2022.
//

import Foundation

extension String {
    
    struct Identifire {
        
        var password = R.string.scenes.password()
        var userName = R.string.scenes.userName()
        var email = R.string.scenes.email()
        var confirmPassword = R.string.scenes.confirmPassword()
        
    }
    
    static let identifier = Identifire()
}
