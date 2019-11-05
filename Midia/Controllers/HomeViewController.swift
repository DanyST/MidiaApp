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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        mediaItems = mediaItemProvider.getHomeMediaItems()
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
