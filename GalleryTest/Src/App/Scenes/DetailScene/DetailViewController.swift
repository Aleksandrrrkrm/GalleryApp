//
//  DetailViewController.swift
//  GalleryTest
//
//  Created by Александр Головин on 09.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageScroll: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var image: UIImage?
    var name: String?
    var descriptionPhoto: String?
    internal var presenter: DetailPresenter?
    // TODO: Что это?
    let wight: CGFloat = 414
    let hight: CGFloat = 272
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        imageView.image = image
        descriptionTextView.text = descriptionPhoto
        
        imageScroll.delegate = self
        imageScroll.minimumZoomScale = 1.0
        imageScroll.maximumZoomScale = 10.0
    }
}


extension DetailViewController: DetailView {
    
}

extension DetailViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView,
                                 with view: UIView?,
                                 atScale scale: CGFloat) {
        if scrollView == imageScroll {
            UIView.animate(withDuration: 0.4,
                           delay: 0.0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.8,
                           animations: {
                self.imageScroll.zoomScale = 1.0
            },
                           completion: nil)
        }
    }
}
