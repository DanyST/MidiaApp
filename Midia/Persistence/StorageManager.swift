//
//  StorageManager.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 23-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

final class StorageManager {
    
    // MARK: - Properties
    
    static var shared = MidiaAppInitialConfigurationConstants.storageManagerKind.instance(withMediaItemKind: MidiaAppInitialConfigurationConstants.mediaItemKind)
    
    // MARK: - Methods
    
    static func setup(withMediaItemKind mediaItemKind: MediaItemKind) {
        shared = MidiaAppInitialConfigurationConstants.storageManagerKind.instance(withMediaItemKind: mediaItemKind)
    }
}
