//
//  AddPhotoViewController.swift
//  GalleryTest
//
//  Created by Александр Головин on 21.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit
import SnapKit
import SwiftEntryKit

class AddPhotoViewController: UIViewController {
    
    
    //MARK: - OUTLETS
    internal var presenter: AddPhotoPresenter?
    var imageView = UIImageView()
    var activityIndicatorView = UIImageView()
    var nameLabel = UITextView()
    var myTextView = UITextView()
    var tap = UITapGestureRecognizer()
    var timer: Timer?
    let placeholderForTextView = R.string.scenes.placeholderForTextView()
    let placeholderForName = R.string.scenes.placeholderForName()
   
    
    //MARK: - LYFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextView.delegate = self
        nameLabel.delegate = self
        configureViews()
    }
    
    
    //MARK: CONFIGURE SCENE
    private func configureViews() {
        
        activityIndicatorView.isHidden = true
        
        view.backgroundColor = .white
        imageView.backgroundColor = .black
        configureImageView()
        configureNameLabel()
        configureTextView()
        configureNavTitle()
        configureTapRecognaizer()
        configureImageViewIndicator()
    }
    
    
    private func configureImageView() {
    
        view.addSubview(imageView)
        imageView.layer.borderWidth = 0.3
        imageView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-4)
            make.height.equalTo(320)
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
    }
    
    
    private func configureNameLabel() {
        
        view.addSubview(nameLabel)
        nameLabel.font = UIFont(name: R.string.scenes.avenirBlack(), size: 15)
        nameLabel.layer.borderWidth = 0.5
        nameLabel.layer.cornerRadius = 10
        nameLabel.text = placeholderForName
        nameLabel.textColor = UIColor.lightGray
        nameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-4)
            make.height.equalTo(40)
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }
    
    
    private func configureTextView() {
        
        view.addSubview(myTextView)
        myTextView.font = UIFont(name: R.string.scenes.avenirBlack(), size: 15)
        myTextView.layer.borderWidth = 0.5
        myTextView.layer.cornerRadius = 10
        myTextView.text = placeholderForTextView
        myTextView.textColor = UIColor.lightGray
        myTextView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-4)
            make.height.equalTo(270)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }
    
    
    private func configureTapRecognaizer() {
        
        view.addGestureRecognizer(tap)
        tap.addTarget(self, action: #selector(tapPressed))
    }
    
    
    //MARK: -  Custom Activity Indicator
    private func configureImageViewIndicator() {
        activityIndicatorView.image = UIImage(resource: R.image.ellipse)
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(80)
        }
    }
    
    
    func startTimer() {
        self.activityIndicatorView.isHidden = false
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
        }
    }
    
    func stopTimer() {
        self.activityIndicatorView.isHidden = true
        timer?.invalidate()
        timer = nil
    }
    
    @objc func animateView() {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseInOut, animations: {
            self.activityIndicatorView.transform = self.activityIndicatorView.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { (finished) in
            if self.timer != nil {
                self.timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
            }
        })
    }
    
    
    
    //MARK: - USAGE
    
    @objc private func tapPressed() {
        
        nameLabel.resignFirstResponder()
        myTextView.resignFirstResponder()
    }
    
    
    private func configureNavTitle() {
        
        let rightButtonItem = UIBarButtonItem.init(
            title: R.string.scenes.add(),
            style: .done,
            target: self,
            action: #selector(addButtonPressed)
        )
        rightButtonItem.tintColor = .purple
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func addButtonPressed() {
        
        if myTextView.text == placeholderForTextView || nameLabel.text == placeholderForName || imageView.image == R.image.placeholder() {
            
            errorAlert(R.string.scenes.someThingWrong(), message: R.string.scenes.recomendation())
        } else {
            startTimer()
            guard let name = nameLabel.text else { return }
            guard let description = myTextView.text else { return }
            
            let photo = PhotoPostEntity(name: name, description: description, image: nil)
            presenter?.addDataButtonPressed(imageView.image!, photo)
            
        }
    }
  
    
   
    
    
}


//MARK: - EXTENSIONS
extension AddPhotoViewController: AddPhotoView {
    
    func errorAlert(_ title: String?, message: String?) {
        guard let title = title else {
            return
        }
        guard let message = message else {
            return
        }
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.scenes.ok(), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - TextViews
extension AddPhotoViewController: UITextViewDelegate {
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        switch textView {
        case myTextView:
            if myTextView.textColor == UIColor.lightGray {
                myTextView.text = nil
                myTextView.textColor = UIColor.black
            }
        case nameLabel:
            if nameLabel.textColor == UIColor.lightGray {
                nameLabel.text = nil
                nameLabel.textColor = UIColor.black
            }
        default:
            return
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        switch textView {
        case myTextView:
            if myTextView.text.isEmpty {
                myTextView.text = placeholderForTextView
                myTextView.textColor = UIColor.lightGray
            }
        case nameLabel:
            if nameLabel.text.isEmpty {
                nameLabel.text = placeholderForName
                nameLabel.textColor = UIColor.lightGray
            }
        default:
            return
        }
    }
}
