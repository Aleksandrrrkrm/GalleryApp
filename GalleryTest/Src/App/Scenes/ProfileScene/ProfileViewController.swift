//
//  ProfileViewController.swift
//  GalleryTest
//
//  Created by Александр Головин on 01.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit
import Rswift

class ProfileViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - OUTLETS
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var collectionUserView: UICollectionView!
    @IBOutlet weak var userPhotosCount: UILabel!
    
    
    internal var presenter: ProfilePresenter?
        
    
    //MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionUserView.delegate = self
        collectionUserView.dataSource = self
        
        ProfileConfigurator.configure(view: self)
        configureNavTitle()
        configureImageView()
        presenter?.getPhoto()
        
        collectionUserView.layer.borderWidth = 1
        collectionUserView.layer.borderColor = R.color.appGrayTextFields()?.cgColor
    }
    
    //MARK: - Compositional Layout
    override func viewDidLayoutSubviews() {
        let spacing: CGFloat = 10
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(90))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 4)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: spacing,
                                      leading: spacing,
                                      bottom: spacing,
                                      trailing: spacing)
        section.interGroupSpacing = spacing
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionUserView.collectionViewLayout = layout
        collectionUserView.collectionViewLayout.invalidateLayout()
    }
    
    //MARK: - Scene
    private func configureImageView() {
        imageView.layer.borderColor = .init(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        imageView.layer.borderWidth = 1
    }
    
    
    private func configureNavTitle() {
        
        let rightButtonItem = UIBarButtonItem.init(image: R.image.icon(),
                                     style: .done,
                                     target: self,
                                     action: #selector(nextButtonPressed))
    
        self.navigationItem.rightBarButtonItem = rightButtonItem
        navigationItem.backButtonTitle = R.string.scenes.cancel()
        navigationController?.navigationBar.tintColor = .black
        
        let leftButtonItem = UIBarButtonItem.init(image: R.image.backImage(),
                                                  style: .done,
                                                  target: self,
                                                  action: #selector(open))
        leftButtonItem.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftButtonItem
    }
    
    @objc func nextButtonPressed() {
        presenter?.openSettings()
    }
    
    @objc func open() {
        tabBarController?.selectedIndex = 0
    }
    
}


//MARK: - EXTENSIONS
extension ProfileViewController: ProfileView { }

extension ProfileViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return presenter?.arrayUserPhotoData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.string.scenes.idcellsUserPhoto(),
                                                         for: indexPath) as? ProfilePhotoCell {
            
            guard let photo = presenter?.arrayUserPhotoData[indexPath.row].image else {
                return UICollectionViewCell()
            }
            cell.setupCell(stringImage: photo.name)
            cell.arrayDataForCell = presenter?.arrayUserPhotoData[indexPath.row]
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate { }
