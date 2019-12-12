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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // Creamos el VC
       guard let detailViewController = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as? DetailViewController else {
           fatalError()
       }
       
       // Le enviamos la info
       let mediaItem = mediaItems[indexPath.item]
       detailViewController.mediaItemId = mediaItem.mediaItemId
       detailViewController.mediaItemProvider = mediaItemProvider
       
       // Mostramos el VC en pantalla
       present(detailViewController, animated: true, completion: nil)
       }
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
        // dismiss keyboard
        searchBar.resignFirstResponder()
        
        // Podriamos añadir delimitaciones de caracteres especiales
        guard let userText = searchBar.text,
            userText.count > 0 else { return }
        
        
        activityIndicator.isHidden = false
        mediaItemProvider.getSearchMediaItems(withQueryParams: userText) { [unowned self] (result) in
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.reset()
        }
    }
}
