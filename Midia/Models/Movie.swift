//
//  Movie.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 28-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

struct Movie {
    // MARK: - Properties
    let movieId: Int
    let title: String
    let directors: [String]? = nil
    let releaseDate: Date? = nil
    let description: String? = nil
    let coverURL: URL? = nil
    let ratings: Float? = nil
    let numberOfReviews: Int? = nil
    let price: Float? = nil
    
//    init(movieId: String, title: String, directors: [String]? = nil, releaseDate: Date? = nil, description: String? = nil, coverURL: URL? = nil, ratings: Float? = nil, numberOfReviews: Int? = nil, price: Float? = nil) {
//        self.movieId = movieId
//        self.title = title
//        self.directors = directors
//        self.releaseDate = releaseDate
//        self.description = description
//        self.coverURL = coverURL
//        self.ratings = ratings
//        self.numberOfReviews = numberOfReviews
//        self.price = price
//    }
}

// MARK: - Codable
extension Movie: Codable {
    enum CodingKeys: String, CodingKey {
        case movieId = "trackId"
        case title = "trackName"
    }
    
    
}

// MARK: - MediaItemProvidable Protocol
extension Movie: MediaItemProvidable {
    var mediaItemId: String {
        return "\(movieId)"
    }
    
    var imageURL: URL? {
        return nil
    }
    
}
