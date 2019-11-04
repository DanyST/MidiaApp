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
    
    // MARK: - Initialization
    init(bookId: String, title: String, authors: [String]? = nil, publishedDate: Date? = nil, description: String? = nil, coverURL: URL? = nil, ratings: Float? = nil, numberOfReviews: Int? = nil, price: Float? = nil) {
        
        self.bookId = bookId
        self.title = title
        self.authors = authors
        self.publishedDate = publishedDate
        self.description = description
        self.coverURL = coverURL
        self.ratings = ratings
        self.numberOfReviews = numberOfReviews
        self.price = price
    }
    
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
    
    // MARK: - Init Decoder for Decodable
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        bookId = try container.decode(String.self, forKey: .bookId)
        
        let volumeInfoContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .volumeInfo)
        title = try volumeInfoContainer.decode(String.self, forKey: .title)
        
        // Para propiedades opcionales utilizamos decodeIfPresent
        authors = try volumeInfoContainer.decodeIfPresent([String].self, forKey: .authors)
        
        if let publishedDateString = try volumeInfoContainer.decodeIfPresent(String.self, forKey: .publishedDate) {
            publishedDate = DateFormatter.booksAPIDateFormatter.date(from: publishedDateString)
        } else {
            publishedDate = nil
        }
    
        description = try volumeInfoContainer.decodeIfPresent(String.self, forKey: .description)
        
        // Es posible que no haya imageLinkContainer, entonces ponemos a nil la coverURL
//        do {
            let imageLinkContainer = try? volumeInfoContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageLinks)
            coverURL = try imageLinkContainer?.decodeIfPresent(URL.self, forKey: .coverURL)
//        } catch {
//            coverURL = nil
//        }
        
        ratings = try volumeInfoContainer.decodeIfPresent(Float.self, forKey: .ratings)
        numberOfReviews = try volumeInfoContainer.decodeIfPresent(Int.self, forKey: .numberOfReviews)
        
        let saleInfoContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .saleInfo)
        let listPriceContainer = try? saleInfoContainer?.nestedContainer(keyedBy: CodingKeys.self, forKey: .listPrice)
        price = try listPriceContainer?.decodeIfPresent(Float.self, forKey: .price)
    }
}

// MARK: - MediaItemProvidable Protocol
extension Book: MediaItemProvidable {
    
    var imageURL: URL? {
        return coverURL
    }
    
}

