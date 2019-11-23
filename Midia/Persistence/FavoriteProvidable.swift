//
//  FavoriteProvidable.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 22-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

protocol FavoritesProvidable {
    
    func getFavorites() -> [MediaItemDetailedProvidable]?
    func getFavorite(byId favoriteId: String) -> MediaItemDetailedProvidable?
    func add(favorite: MediaItemDetailedProvidable)
    func remove(favoriteWithId favoriteId: String)
    
}
