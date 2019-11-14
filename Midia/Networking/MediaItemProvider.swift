//
//  MediaItemProvider.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 04-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

final class MediaItemProvider {
    // MARK: - Properties
    private let mediaItemKind: MediaItemKind
    private let apiConsumer: MediaItemAPIConsumable
    
    // MARK: - Initialization
    init(withMediaItemKind mediaItemKind: MediaItemKind, apiConsumer: MediaItemAPIConsumable) {
        self.mediaItemKind = mediaItemKind
        self.apiConsumer = apiConsumer
    }
    
    convenience init(withMediaItemKind mediaItemKind: MediaItemKind) {
        switch mediaItemKind {
        case .book:
            self.init(withMediaItemKind: mediaItemKind, apiConsumer: GoogleBooksAPIConsumerAlamofire())
        case .movie, .game:
            fatalError("Not supported movie yet :( coming soon")
        }
    }
    
    // MARK: - Methods
    func getHomeMediaItems(completion: @escaping (Result<[MediaItemProvidable], Error>) -> Void) {
        apiConsumer.getLatestMediaItems { (result) in
            switch result {
            case .success(let mediaItems):
                assert(Thread.current == Thread.main)
                completion(.success(mediaItems))
                break
            case .failure(let error):
                assert(Thread.current == Thread.main)
                completion(.failure(error))
                break
            }
        }
    }
    
}
