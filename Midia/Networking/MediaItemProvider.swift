//
//  MediaItemProvider.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 04-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

class MediaItemProvider {
    // MARK: - Properties
    private let mediaItemKind: MediaItemKind
    private let apiConsumer: MediaItemAPIConsumable
    
    // MARK: - Initialization
    private init(withMediaItemKind mediaItemKind: MediaItemKind, apiConsumer: MediaItemAPIConsumable) {
        self.mediaItemKind = mediaItemKind
        self.apiConsumer = apiConsumer
    }
    
    convenience init(withMediaItemKind mediaItemKind: MediaItemKind) {
        switch mediaItemKind {
        case .book:
            self.init(withMediaItemKind: mediaItemKind, apiConsumer: MockMediaItemAPIConsumer())
        case .game:
            self.init(withMediaItemKind: mediaItemKind, apiConsumer: MockMediaItemAPIConsumer())
        case .movie:
            fatalError("Not supported movie yet :( coming soon")
        }
    }
    
    func getHomeMediaItems() -> [MediaItemProvidable] {
        // guardar cache
        // comprobar que estamos en el hilo principal
        return apiConsumer.getLatestMediaItems()
    }
    
}


class MockMediaItemAPIConsumer: MediaItemAPIConsumable {
    func getLatestMediaItems() -> [MediaItemProvidable] {
        return [Game()]
    }
    
}
