//
//  ErrorEntity .swift
//  GalleryTest
//
//  Created by Александр Головин on 05.09.2022.
//

import Foundation
import UIKit

enum ErrorValidate: Error {
    
    case invalidSymbol
    case lengthPassword
    case invalidEmail
    case passwordWrong
    case emptyFields
}
