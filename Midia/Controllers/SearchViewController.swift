//
//  SearchViewController.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 18-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var mediaItemProvider: MediaItemProvider!
    var mediaItems: [MediaItemProvidable] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add delegates
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    // TODO: Cuando seleccione el usuario una celda, nos vamos al detalle del media item
    
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Get model
        let mediaItem = mediaItems[indexPath.item]
        
        // Create cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaItemCollectionViewCell.reuseIdentifier, for: indexPath) as! MediaItemCollectionViewCell
        
        // Sync model with view
        cell.mediaItem = mediaItem
        
        return cell
    }

}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    // TODO: hacer la busqueda, pintar los resultados
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Podriamos añadir delimitaciones de caracteres especiales
        guard let queryParams = searchBar.text,
            queryParams.count > 0 else { return }
        
        
        activityIndicator.isHidden = false
        mediaItemProvider.getSearchMediaItems(withQueryParams: queryParams) { [unowned self] (result) in
            switch result {
            case .success(let mediaItems):
                self.mediaItems = mediaItems
                self.collectionView.reloadData()
                self.activityIndicator.isHidden = true
                break
            case .failure(_):
                // TODO: Añadir mensaje que no se han encontrado items
                self.activityIndicator.isHidden = true
                break
            }
        }
    }
}
