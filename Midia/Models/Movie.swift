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
    let movieId: String
    let title: String
    let directors: [String]?
    let releaseDate: Date?
    let description: String?
    let coverURL: URL?
    let ratings: Float?
    let numberOfReviews: Int?
    let price: Float?
    
    init(movieId: String, title: String, directors: [String]? = nil, releaseDate: Date? = nil, description: String? = nil, coverURL: URL? = nil, ratings: Float? = nil, numberOfReviews: Int? = nil, price: Float? = nil) {
        self.movieId = movieId
        self.title = title
        self.directors = directors
        self.releaseDate = releaseDate
        self.description = description
        self.coverURL = coverURL
        self.ratings = ratings
        self.numberOfReviews = numberOfReviews
        self.price = price
    }
}

// MARK: - Codable
extension Movie: Codable {
    enum CodingKeys: String, CodingKey {
        case movieId = "trackId"
        case title = "trackName"
        case directors = "artistName"
        case releaseDate
        case description = "longDescription"
        case coverURL = "artworkUrl100"
        case ratings
        case numberOfReviews
        case price = "trackPrice"
    }
    
    // MARK: - Init Decoder for Decodable
    init(from decoder: Decoder) throws {
        // Container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode All Properties
        let movieIdInt = try container.decode(Int.self, forKey: .movieId)
        movieId = "\(movieIdInt)"
        
        title = try container.decode(String.self, forKey: .title)
        directors = try container.decodeIfPresent(String.self, forKey: .directors)?.components(separatedBy: ",")
        
        if let releaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
            releaseDate = DateFormatter.iTunesAPIDateFormatter.date(from: releaseDateString)
        } else {
            releaseDate = nil
        }
        
        description = try container.decodeIfPresent(String.self, forKey: .description)
        coverURL = try container.decodeIfPresent(URL.self, forKey: .coverURL)
        
        ratings = nil
        numberOfReviews = nil
        price = try container.decodeIfPresent(Float.self, forKey: .price)
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

// MARK: - MediaItemDetailedProvidable Protocol
extension Movie: MediaItemDetailedProvidable {
    var creatorName: String? {
        return directors?.joined(separator: ", ")
    }
    
    var creationDate: Date? {
        return releaseDate
    }
    
}
