//
//  Book.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 30-10-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

struct Book {
    
    // MARK: - Properties
    let bookId: String
    let title: String
    let authors: [String]?
    let publishedDate: Date?
    let description: String?
    let coverURL: URL?
    let ratings: Float?
    let numberOfReviews: Int?
    let price: Float?
    
}

// MARK: - Decodable
extension Book: Decodable {
    
    // Chosing codingKeys
    enum CodingKeys: String, CodingKey {
        // Creamos otra key solo cuando es diferente
        // Si tenemos una key anidada, creamos la key de primer nivel
        case bookId = "id"
        case volumeInfo
        case title
        case authors
        case publishedDate
        case description
        case imageLinks
        case coverURL = "thumbnail"
        case ratings = "averageRating"
        case numberOfReviews = "ratingsCount"
        case saleInfo
        case listPrice
        case price = "amount"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        bookId = try container.decode(String.self, forKey: .bookId)
        
        let volumeInfo = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .volumeInfo)
        title = try volumeInfo.decode(String.self, forKey: .title)
        
        // TODO: Completar las demas propiedades
        authors = nil
        publishedDate = nil
        description = nil
        coverURL = nil
        ratings = nil
        numberOfReviews = nil
        price = nil
    }
}


