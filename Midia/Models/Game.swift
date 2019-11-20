//
//  Game.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 04-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

struct Game: MediaItemProvidable, MediaItemDetailedProvidable {
    
    // MARK: - Properties
    var mediaItemId: String = "12345"
    var title: String = "A game"
    var imageURL: URL? = nil
    var creatorName: String? = nil
    var ratings: Float? = nil
    var numberOfReviews: Int? = nil
    var creationDate: Date? = nil
    var price: Float? = nil
    var description: String? = nil
}
