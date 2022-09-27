//
//  MainPhotoCell.swift
//  GalleryTest
//
//  Created by Александр Головин on 06.09.2022.
//


import UIKit
import Kingfisher


protocol MainPhotoCell: UICollectionViewCell {
    
    var arrayDataForCell: PhotoData? { get set }
    func setupCell (stringImage: String)
    var imageView: UIImageView! { get set }
}



class MainPhotoCellImp: UICollectionViewCell, MainPhotoCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var arrayDataForCell: PhotoData?
    
    func setupCell (stringImage: String) {
            guard let url = URL(string: "https://gallery.prod1.webant.ru/media/\(stringImage)")
            else {
                return
            }
        

        
           
        
            self.imageView.kf.indicatorType = .activity
            self.imageView.kf.setImage(with: url)
                
            
            self.layer.cornerRadius = 10
        
    }
}
