//
//  MainViewController.swift
//  GalleryTest
//
//  Created by Александр Головин on 29.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit
import SnapKit
import DITranquillity
import RxNetworkApiClient

class MainViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    
    //MARK: - OUTLETS
    
    private var searchBar = UISearchBar()
    private var imageView = UIImageView()
    private var imageViewError = UIImageView()
    let custom = CustomSegmentedControl()
    private let layout = UICollectionViewFlowLayout()
    
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var timer: Timer?
    internal var presenter: MainPresenter?
    var detailView: DetailView?
    var cell: MainPhotoCell?
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        MainConfigurator.configure(view: self)
        settingsView()
    }
    
    
    // MARK: - Configure Views
    
    // SearchBar
    private func configureSearchBar() {
        
        self.navigationItem.titleView = searchBar
        searchBar.placeholder = R.string.scenes.searchbarPlaceholder()
    }
    
    
    private func configureCustom() {
    
        custom.items = [R.string.scenes.new(), R.string.scenes.popular()]
        custom.unselectedLabelColor = .gray
        custom.thumbColor = .purple
        custom.font = UIFont(name: R.string.scenes.avenirBlack(), size: 18)
        custom.borderColor = UIColor(white: 1.0, alpha: 0.3)
        custom.selectedIndex = 0
        custom.padding = 2
        segmentView.addSubview(custom)
        custom.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //action
        custom.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
    }
    
    
    //MARK: -  Custom Activity Indicator
    private func configureImageView() {
        imageView.image = UIImage(resource: R.image.ellipse)
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(80)
        }
    }
    
    
    func startTimer() {
        self.imageView.isHidden = false
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
        }
    }
    
    func stopTimer() {
        self.imageView.isHidden = true
        timer?.invalidate()
        timer = nil
    }
    
    @objc func animateView() {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseInOut, animations: {
            self.imageView.transform = self.imageView.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { (finished) in
            if self.timer != nil {
                self.timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
            }
        })
    }
    
    // MARK: - Error Image
    
    func configureErrorImage() {
        
        imageViewError.image = UIImage(resource: R.image.errorIcon)
        self.view.addSubview(imageViewError)
        imageViewError.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(150)
        }
    }
    
    //SettingsViewDidLoad
    private func settingsView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        configureImageView()
        collectionView.refreshControl = myRefreshControl
        imageView.isHidden = true
        imageViewError.isHidden = true
        presenter?.currentPage = 1
        presenter?.getPhoto(isNew: true, for: nil)
        configureSearchBar()
        configureCustom()
        configureErrorImage()
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
            heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = spacing
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = layout
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    // MARK: - USAGE
    
    @objc func segmentValueChanged(_ sender: AnyObject){
        presenter?.arrayPhotoData = []
//        collectionView.reloadData()
        presenter?.currentPage = 1
        trueUrlForPhoto()
    }
    
    
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == (presenter?.arrayPhotoData.count ?? 1) - 1 {
            guard let totalItems = presenter?.totalItems,
                  (presenter?.currentPage)! <= totalItems
            else {
                return
            }
            trueUrlForPhoto()
        }
    }
    
    private var myRefreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        
        return refreshControl
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        presenter?.arrayPhotoData = []
        presenter?.currentPage = 1
        trueUrlForPhoto()
        collectionView.reloadData()
        sender.endRefreshing()
    }
    
    
    // MARK: - Helpers
    
    private func trueUrlForPhoto() {
        
        switch custom.selectedIndex {
        case 0:
            presenter?.getPhoto(isNew: true, for: nil)
        case 1:
            presenter?.getPhoto(isNew: false, for: nil)
        default:
            return
        }
    }
}


// MARK: - Extension

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.presenter?.arrayPhotoData = []
            self.presenter?.currentPage = 1
            switch self.custom.selectedIndex {
            case 0:
                self.presenter?.getPhoto(isNew: true, for: searchText)
            case 1:
                self.presenter?.getPhoto(isNew: false, for: searchText)
            default:
                return
            }
        })
        collectionView.reloadData()
    }
}


extension MainViewController: MainView {
    
}


extension MainViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.arrayPhotoData.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.string.scenes.idCellsPhoto(), for: indexPath) as? MainPhotoCell {
            
            guard let photo = presenter?.arrayPhotoData[indexPath.row].image else { return UICollectionViewCell() }
            cell.setupCell(stringImage: photo.name)
            cell.arrayDataForCell = presenter?.arrayPhotoData[indexPath.row]
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let photoData = collectionView.cellForItem(at: indexPath) as? MainPhotoCell else {
            return
        }
        guard let photo = photoData.imageView.image else { return }
        guard let photoObject = presenter?.arrayPhotoData[indexPath.row].name else { return }
        let description = presenter?.arrayPhotoData[indexPath.row].description
        presenter?.openDetailScene(photoName: photoObject, photo: photo, description: description)
    }
    
    
}

extension MainViewController: UICollectionViewDelegate {
    
}


