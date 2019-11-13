//
//  HomeViewController.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 02-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    var mediaItemProvider: MediaItemProvider!
    private var mediaItems: [MediaItemProvidable] = []
        
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var failureEmojiLabel: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Asiganmos delegados
        collectionView.delegate = self
        collectionView.dataSource = self

        
        mediaItemProvider.getHomeMediaItems { [unowned self] (result) in
            switch result {
            case .success(let mediaItems):
                self.mediaItems = mediaItems
                self.collectionView.reloadData()
                self.activityIndicatorView.isHidden = true
                break
            case .failure(_):
                self.activityIndicatorView.isHidden = true
                self.failureEmojiLabel.isHidden = false
                break
            }
        }
        
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let mediaItem = mediaItems[indexPath.item]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaItemCollectionViewCell.reuseIdentifier, for: indexPath) as! MediaItemCollectionViewCell
                
        cell.mediaItem = mediaItem
        
        return cell
    }
    
    
}
