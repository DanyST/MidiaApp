//
//  FavoritesViewController.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 22-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var favorites: [MediaItemDetailedProvidable] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Añadimos delegados
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // cargar los favorites
        loadFavorites()
    }
    
}

// MARK: - Methods
extension FavoritesViewController {
    func loadFavorites() {
        // coger los favoritos desde el storage manager
        guard let storedFavorites = StorageManager.shared.getFavorites() else  { return }
        
        self.favorites = storedFavorites
        self.tableView.reloadData()
    }
}

// MARK: - UI TableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Creamos el detailViewController
        guard let detailViewController = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as? DetailViewController else {
            fatalError()            
        }
        
        // obtener el modelo en cuestión
        let mediaItem = favorites[indexPath.row]
        
        // Añadir el mediaItemId a detailVC
        detailViewController.mediaItemId = mediaItem.mediaItemId
        
        // nos conformamos como delegado de detailViewController para obtener mensajes de cambios en favoritos
        detailViewController.delegate = self
        
        // Mostrar detailVC
        self.present(detailViewController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Creamos el modelo
        let favoriteMediaItem = favorites[indexPath.row]
        
        // Creamos la celda en cuestion
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier) as! FavoriteTableViewCell // Estamos seguros de que existe
        
        // Sincronizamos modelo y vista
        cell.mediaItem = favoriteMediaItem
        
        // Devolver celda
        return cell
    }
}

// MARK: - DetailViewControllerDelegate
extension FavoritesViewController: DetailViewControllerDelegate {
    func detailViewController(_ vc: DetailViewController, didToggleFavorite favorite: MediaItemDetailedProvidable, withFavoriteToggleKind toggleKind: FavoriteToggleKind) {
        
        // Recargar los favoritos
        loadFavorites()
    }
}
