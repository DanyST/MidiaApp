//
//  StorageManagerKind.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 03-12-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

enum StorageManagerKind {
    case userDefaults
    case coreData
    
    @available(*, unavailable)
    case realm, firebase
    
    func instance(withMediaItemKind mediaItemKind: MediaItemKind) -> FavoritesProvidable {
        switch self {
        case .userDefaults:
            return UserDefaultStorageManager(withMediaItemKind: mediaItemKind)
        case .coreData:
            return CoreDataStorageManager(withMediaItemKind: mediaItemKind)
        }
        
    }
}
