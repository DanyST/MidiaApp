//
//  MediaItemDetailedProvidable.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 19-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

protocol MediaItemDetailedProvidable {
    
    var mediaItemId: String { get }
    var title: String { get }
    var imageURL: URL? { get }
    var creatorName: String? { get }
    var ratings: Float? { get }
    var numberOfReviews: Int? { get }
    var creationDate: Date? { get }
    var price: Float? { get }
    var description: String? { get }
    
}
