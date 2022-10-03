//
//  PhotoViewController.swift
//  GalleryTest
//
//  Created by Александр Головин on 01.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit
import SnapKit
import Photos
import PhotosUI

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    internal var presenter: PhotoPresenter?
    var imagePicker = UIImagePickerController()
    var testView = UIView()
    var image: UIImage?
    
    var imageLibrary = UIImagePickerController()

    var actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = R.string.scenes.emptyLine()
        navigationController?.navigationBar.tintColor = .black
        imageLibrary.delegate = self
        imageLibrary.sourceType = .photoLibrary
        imageLibrary.allowsEditing = false
        addActionsForSheetAlert()
        PhotoConfigurator.configure(view: self)
        image = R.image.placeholder()
        collectionView.delegate = self
        collectionView.dataSource = self
        imagePicker.delegate = self
        configureNavTitle()
        getPhoto()
    }
    
    
    
    //MARK: - Layout
    override func viewDidLayoutSubviews() {
        
        let spacing: CGFloat = 10
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 3)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: spacing,
                                      leading: spacing,
                                      bottom: spacing,
                                      trailing: spacing)
        section.interGroupSpacing = spacing
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = layout
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    
    // MARK: - USAGE
    
    func getPhoto() {
        presenter?.getImages()
    }
    
   
    func cameraButton() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            imageLibrary.sourceType = .camera
            imageLibrary.allowsEditing = true
            self.present(imageLibrary,
                         animated: true,
                         completion: nil)
        } else {
            let alert  = UIAlertController(title: R.string.scenes.warning(),
                                           message: R.string.scenes.noneCamera(),
                                           preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: R.string.scenes.ok(),
                                          style: .default,
                                          handler: nil))
                    self.present(alert,
                                 animated: true,
                                 completion: nil)
        }
    }
  
    
    func galleryButton() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            imageLibrary.sourceType = .photoLibrary
            imageLibrary.allowsEditing = false
            self.present(imageLibrary, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title:R.string.scenes.warning(),
                                           message: R.string.scenes.noneGallery(),
                                           preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: R.string.scenes.ok(),
                                          style: .default,
                                          handler: nil))
            self.present(alert,
                         animated: true,
                         completion: nil)
        }
    }

    // TapOnTheImageView
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
    
        self.present(actionSheet,
                     animated: true,
                     completion: nil)
    }
    
    
    //MARK: - CONFIGURE SCENE
    
    private func addActionsForSheetAlert() {
        
        actionSheet.addAction(UIAlertAction(title: R.string.scenes.selectPhoto(),
                                            style: .default,
                                            handler: { action in
            self.galleryButton()
        }))
        
        actionSheet.addAction(UIAlertAction(title: R.string.scenes.openCamera(),
                                            style: .default,
                                            handler: { action in
            self.cameraButton()
        }))
        
        actionSheet.addAction(UIAlertAction(title: R.string.scenes.cancel(),
                                            style: .cancel,
                                            handler: { _ in
            
        }))
    }
    
    // NavigationTitle
    private func configureNavTitle() {
        
        let rightButtonItem = UIBarButtonItem.init(
            title: R.string.scenes.next(),
            style: .done,
            target: self,
            action: #selector(nextButtonPressed)
        )
        rightButtonItem.tintColor = .purple
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    @objc func nextButtonPressed() {
        
        presenter?.addPhoto(image: image!)
    }
    
   
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            print(pickedImage)
            image = pickedImage
            imageView.image = pickedImage
            self.dismiss(animated: true)
    }
}
    
    
    
    
    
}






// MARK: - EXTENSIONS

extension PhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.string.scenes.myCell(), for: indexPath) as? MyCell {
            let photo = presenter?.allImages[indexPath.row]
            cell.imageView.image = photo
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        presenter?.countOfPhoto ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let photoData = collectionView.cellForItem(at: indexPath) as? MyCell else {
            return
        }
        
        imageView.alpha = 0.0
        guard let photo = photoData.imageView.image else { return }
        self.imageView.image = photo
        self.image = photo
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
        self.imageView.alpha = 1
        }) { _ in
        
                photoData.alpha = 0.5
        }
    }
    
    
    
}

extension PhotoViewController: PhotoView {
    
}

