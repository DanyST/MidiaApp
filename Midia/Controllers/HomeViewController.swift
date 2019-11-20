//
//  HomeViewController.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 02-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import UIKit

enum MediaItemViewControllerState {
    case loading
    case noResults
    case failure
    case ready
}

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var failureEmojiLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    // MARK: - Properties
    var mediaItemProvider: MediaItemProvider!
    private var mediaItems: [MediaItemProvidable] = []

    var state: MediaItemViewControllerState = .ready {
        willSet {
            guard state != newValue else { return }

            // ocultamos todas las vistas relacionadas con los estados y despues mostramos las que corresponden
            [collectionView, activityIndicatorView, failureEmojiLabel, statusLabel].forEach { view in
                view?.isHidden = true
            }

            switch newValue {
            case .loading:
                activityIndicatorView.isHidden = false
                break
            case .noResults:
                failureEmojiLabel.isHidden = false
                failureEmojiLabel.text = "🙁"
                statusLabel.isHidden = false
                statusLabel.text = "There are results..."
                break
            case .failure:
                failureEmojiLabel.isHidden = false
                failureEmojiLabel.text = "❌"
                statusLabel.isHidden = false
                statusLabel.text = "Connection error!!"
                break
            case .ready:
                collectionView.isHidden = false
                collectionView.reloadData()
                break
            }
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Asiganmos delegados
        collectionView.delegate = self
        collectionView.dataSource = self

        self.state = .loading
        mediaItemProvider.getHomeMediaItems { [unowned self] (result) in
            switch result {
            case .success(let mediaItems):
                self.mediaItems = mediaItems
                self.state = mediaItems.count > 0 ? .ready : .noResults
                break
            case .failure(_):
                self.state = .failure
                break
            }
        }
        
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Creamos el VC
        guard let detailViewController = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as? DetailViewController else {
            fatalError()
        }
        
        detailViewController.modalPresentationStyle = .fullScreen
        
        // Le enviamos la info
        let mediaItem = mediaItems[indexPath.item]
        detailViewController.mediaItemId = mediaItem.mediaItemId
        detailViewController.mediaItemProvider = mediaItemProvider
        
        // Mostramos el VC en pantalla
        present(detailViewController, animated: true, completion: nil)
    }
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
