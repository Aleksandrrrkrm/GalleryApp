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
    var viewForText = UIView()
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
        view.backgroundColor = .init(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        imageView.backgroundColor = .black
        configureImageView()
        configureViewForView()
        configureNameLabel()
        configureTextView()
        configureNavTitle()
        configureTapRecognaizer()
        configureImageViewIndicator()
    }
        
    private func configureImageView() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(280)
            make.top.equalToSuperview().offset(100)
        }
    }
    
    private func configureViewForView() {
        viewForText.layer.borderColor = .init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        viewForText.layer.borderWidth = 1
        view.addSubview(viewForText)
        viewForText.backgroundColor = .white
        viewForText.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(63)
            make.bottom.equalToSuperview()
        }
    }
    
    
    private func configureNameLabel() {
        viewForText.addSubview(nameLabel)
        nameLabel.font = UIFont(name: R.string.scenes.arial(),
                                size: 17)
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.cornerRadius = 4
        nameLabel.layer.borderColor = .init(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        nameLabel.text = placeholderForName
        nameLabel.textColor = R.color.appGrayTextFields()
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(36)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    private func configureTextView() {
        viewForText.addSubview(myTextView)
//        myTextView.font = UIFont(name: R.string.scenes.avenirBlack(),
//                                 size: 15)
        myTextView.font = UIFont(name: R.string.scenes.arial(),
                                 size: 17)
        myTextView.layer.borderWidth = 1
        myTextView.layer.cornerRadius = 4
        myTextView.layer.borderColor = .init(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        myTextView.text = placeholderForTextView
        myTextView.textColor = R.color.appGrayTextFields()
        myTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(150)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
    }
    
    private func configureTapRecognaizer() {
        
        view.addGestureRecognizer(tap)
        tap.addTarget(self,
                      action: #selector(tapPressed))
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
            timer = Timer.scheduledTimer(timeInterval:0.0,
                                         target: self,
                                         selector: #selector(self.animateView),
                                         userInfo: nil,
                                         repeats: false)
        }
    }
    
    func stopTimer() {
        self.activityIndicatorView.isHidden = true
        timer?.invalidate()
        timer = nil
    }
    
    @objc func animateView() {
        UIView.animate(withDuration: 0.7,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
            self.activityIndicatorView.transform = self.activityIndicatorView.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { (finished) in
            if self.timer != nil {
                self.timer = Timer.scheduledTimer(timeInterval:0.0,
                                                  target: self,
                                                  selector: #selector(self.animateView),
                                                  userInfo: nil,
                                                  repeats: false)
            }
        })
    }
    
    //MARK: - USAGE
    @objc private func tapPressed() {
        nameLabel.resignFirstResponder()
        myTextView.resignFirstResponder()
    }
    //nav title
    private func configureNavTitle() {
        
        let rightButtonItem = UIBarButtonItem.init(
            title: R.string.scenes.add(),
            style: .done,
            target: self,
            action: #selector(addButtonPressed)
        )
        rightButtonItem.tintColor = R.color.appPink()
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func addButtonPressed() {
        if myTextView.text == placeholderForTextView || nameLabel.text == placeholderForName || imageView.image == R.image.placeholder() || myTextView.text == nil || nameLabel.text == nil {
            errorAlert(R.string.scenes.someThingWrong(), message: R.string.scenes.recomendation())
        } else {
            startTimer()
            guard let name = nameLabel.text else {
                return
            }
            guard let description = myTextView.text else {
                return
            }
            let photo = PhotoPostEntity(name: name,
                                        description: description,
                                        image: nil)
            guard let image = imageView.image else { 
                return
                }
            presenter?.addDataButtonPressed(image,
                                            photo)
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
        let alert  = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.scenes.ok(),
                                      style: .default,
                                      handler: nil))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
}

//MARK: - TextViews
extension AddPhotoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        switch textView {
        case myTextView:
            if myTextView.textColor == R.color.appGrayTextFields() {
                myTextView.text = nil
                myTextView.textColor = .black
            }
        case nameLabel:
            if nameLabel.textColor == R.color.appGrayTextFields() {
                nameLabel.text = nil
                nameLabel.textColor = .black
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
                myTextView.textColor = .lightGray
            }
        case nameLabel:
            if nameLabel.text.isEmpty {
                nameLabel.text = placeholderForName
                nameLabel.textColor = .lightGray
            }
        default:
            return
        }
    }
}
