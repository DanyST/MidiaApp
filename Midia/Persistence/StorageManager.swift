//
//  StorageManager.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 23-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

final class StorageManager {
    
//    static let shared = UserDefaultStorageManager(withMediaItemKind: .movie)
    static let shared = CoreDataStorageManager(withMediaItemKind: .movie)
}
