//
//  ProfilePhotoCell.swift
//  GalleryTest
//
//  Created by Александр Головин on 23.09.2022.
//

import UIKit
import Kingfisher


import UIKit
import Kingfisher


protocol ProfilePhotoCell: UICollectionViewCell {
    
    var arrayDataForCell: PhotoData? { get set }
    func setupCell (stringImage: String)
    var userImageView: UIImageView! { get set }
}



class ProfilePhotoCellImp: UICollectionViewCell, ProfilePhotoCell {
    
  
    @IBOutlet weak var userImageView: UIImageView!
    
    var arrayDataForCell: PhotoData?
    
    func setupCell (stringImage: String) {
            guard let url = URL(string: "https://gallery.prod1.webant.ru/media/\(stringImage)")
            else {
                return
            }
    
    
    self.userImageView.kf.indicatorType = .activity
    self.userImageView.kf.setImage(with: url)
        
    
    self.layer.cornerRadius = 10
    }
    
}
