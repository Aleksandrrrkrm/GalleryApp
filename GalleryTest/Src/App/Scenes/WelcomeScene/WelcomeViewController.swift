//
//  WelcomeViewController.swift
//  GalleryTest
//
//  Created by Александр Головин on 25.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    
    internal var presenter: WelcomePresenter?
    
    @IBOutlet weak var imageWebant: UIImageView!
    @IBOutlet weak var labelWelcomeText: UILabel!
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var buttonAuthorization: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if presenter == nil {
            WelcomeConfigurator.configure(view: self)
        }
        configureButtons() 
    }
    
    
    
    
    func setupStrings() {
        // Setup localizable strings
    }
    
    
    
    
    // MARK: - Configure Views
    func configureButtons() {
        
        buttonRegister.layer.cornerRadius = 4
        buttonRegister.tag = 1
        buttonRegister.addTarget(self,
                                 action: #selector(click(button:)),
                                 for: .touchUpInside)
        buttonAuthorization.layer.cornerRadius = 4
        buttonAuthorization.layer.borderWidth = 1
        buttonAuthorization.tag = 2
        buttonAuthorization.addTarget(self,
                                      action: #selector(click(button:)),
                                      for: .touchUpInside)
    }
    
    @objc func click(button sender: UIButton) {
        switch sender {
        case buttonRegister:
            presenter?.registerButtonPressed()
        case buttonAuthorization:
            presenter?.authButtonPressed()
        default:
            return
        }
    }
}

// MARK: - Extensions
extension WelcomeViewController: WelcomeView { }
