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

    private var textField = UITextField()
    private let textFieldButton = UIButton(type: .system)
    private var insetX: CGFloat = 6 {
       didSet {
         layoutIfNeeded()
       }
    }
    private var insetY: CGFloat = 6 {
       didSet {
         layoutIfNeeded()
       }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        configureTextField()
    }
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX , dy: insetY)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX , dy: insetY)
    }
    
    private func configureTextField() {
        isSecureTextEntry = true
        layer.cornerRadius = 4
        layer.borderColor = .init(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        layer.borderWidth = 1
        backgroundColor = .white
    }
    

    
    func configureView(for status: Images) {
        switch status {
        case .password:
            textFieldButton.setImage(R.image.eyeClose(), for: .normal)
        case .name:
            textFieldButton.setImage(R.image.name(), for: .normal)
            textFieldButton.isUserInteractionEnabled = false
        case .birthday:
            textFieldButton.setImage(R.image.calendar(), for: .normal)
            textFieldButton.isUserInteractionEnabled = false
        case .email:
            textFieldButton.setImage(R.image.email(), for: .normal)
            textFieldButton.isUserInteractionEnabled = false
        }
        textFieldButton.contentMode = .scaleAspectFit
        textFieldButton.tintColor = .init(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        textFieldButton.backgroundColor = .clear
        textFieldButton.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
        textFieldButton.addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)
        rightViewMode = UITextField.ViewMode.always
        rightView = textFieldButton
    }
    
    @objc private func showPassword(_ sender: UIButton) {
        if self.isSecureTextEntry == true {
            sender.setImage(R.image.eyeOpen(), for: .normal)
            self.isSecureTextEntry = false
        }
        else {
            self.isSecureTextEntry = true
            textFieldButton.setImage(R.image.eyeClose(), for: .normal)
        }
    }

    @objc private func hidePassword() {
        self.isSecureTextEntry = true
    }

}
    

