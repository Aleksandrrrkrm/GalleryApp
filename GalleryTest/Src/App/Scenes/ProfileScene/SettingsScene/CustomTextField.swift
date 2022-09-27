//
//  CustomTextField.swift
//  GalleryTest
//
//  Created by Александр Головин on 26.09.2022.
//

import UIKit
import SnapKit

enum Images {
    
    case password
    case name
    case birthday
    case email
    
}

class CustomTextField: UITextField {
    
    
    private var textfield = UITextField()
    
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        configureTextField()
    }
    
    
    
    private func configureTextField() {
        
        isSecureTextEntry = true
        layer.cornerRadius = 5
        layer.borderColor = CGColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        layer.borderWidth = 0.5
        
        backgroundColor = .white
        
        layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        
    }
    
    func configureView(for status: Images) {
        
        let textFieldImageView = UIImageView(frame: CGRect(x: 8.0, y: 12.0, width: 20.0, height: 20.0))
        
        switch status {
        case .password:
            textFieldImageView.image = R.image.eye()
        case .name:
            textFieldImageView.image = R.image.name()
        case .birthday:
            textFieldImageView.image = R.image.calendar()
        case .email:
            textFieldImageView.image = R.image.email()
            
        }
        
        textFieldImageView.contentMode = .scaleAspectFill
        textFieldImageView.tintColor = .gray
        textFieldImageView.backgroundColor = .clear
        let textFieldView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: 40))
        textFieldView.addSubview(textFieldImageView)
        textFieldView.backgroundColor = .clear
        rightViewMode = UITextField.ViewMode.always
        rightView = textFieldView
        
    }
    
    
}
