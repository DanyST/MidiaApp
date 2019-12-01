//
//  UserDefaultStorageManager.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 23-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

final class UserDefaultStorageManager: FavoritesProvidable {
    
    // MARK: - Properties
    private let userDefaults = UserDefaults.standard
    private let mediaItemKind: MediaItemKind
    private let favoritesKey: String
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // MARK: - Initialization
    init(withMediaItemKind mediaItemKind: MediaItemKind) {
        self.mediaItemKind = mediaItemKind
        self.favoritesKey = "favorite\(mediaItemKind)"
    }
    
    // MARK: - Methods
    func getFavorites() -> [MediaItemDetailedProvidable]? {
        // Obtenemos el Data de favorites
        guard let favoritesData = userDefaults.data(forKey: favoritesKey) else { return nil }
    
        // Devolvemos el array de favoritos dependiendo del mediaItemKind instanciado en la clase
        switch mediaItemKind {
        case .book:
            return try? decoder.decode([Book].self, from: favoritesData)
        case .movie:
            return try? decoder.decode([Movie].self, from: favoritesData)
        default:
            fatalError("Media Kind \(mediaItemKind) not supported yet :(")
        }
    }
    
    func getFavorite(byId favoriteId: String) -> MediaItemDetailedProvidable? {
        guard let favorites = getFavorites() else { return nil }
        
        // devuelve nil si no encuentra un Media Item con el Id que se busca
        return favorites.first { $0.mediaItemId == favoriteId }
    }
    
    func add(favorite: MediaItemDetailedProvidable) {
        // Verificar que el favorite no existe
        guard getFavorite(byId: favorite.mediaItemId) == nil else { return }
        
        if var favorites = getFavorites() {
            favorites.append(favorite)
            // guardar en userDefaults
            save(favorites: favorites)
        } else {
            // guardar
            save(favorites: [favorite])
        }
    }
    
    func remove(favoriteWithId favoriteId: String) {
        // Verificar que el favorite existe y hay una lista de este ultimo
        guard getFavorite(byId: favoriteId) != nil,
            let favorites = getFavorites() else { return }
        
        // Filtrar todos los favorites que no coincidan con el favoriteId de la función
        let filteredFavorites = favorites.filter { $0.mediaItemId != favoriteId }
        
        // Guardar
        save(favorites: filteredFavorites)
    }
    
    private func save(favorites: [MediaItemDetailedProvidable]) {
        switch mediaItemKind {
        case .book:
            // Convertir favorites de [Book] a Data
            guard let favoritesData = try? encoder.encode(favorites as? [Book]) else {
                fatalError("error encoding favorites")
            }
            
            // Guardar nuevo Data en UserDefaults
            userDefaults.set(favoritesData, forKey: favoritesKey)
            userDefaults.synchronize()
            
        case .movie:
            // Convertir favorites de [Movie] a Data
            guard let favoritesData = try? encoder.encode(favorites as? [Movie]) else {
                fatalError("error encoding favorites")
            }
            
            userDefaults.set(favoritesData, forKey: favoritesKey)
            userDefaults.synchronize()
            
        default:
            fatalError("Media Kind \(mediaItemKind) not supported yet :(")
        }
    }
    
}
