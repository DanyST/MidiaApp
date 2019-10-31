//
//  Book.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 30-10-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

struct Book {
    
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

extension Book: Decodable {}
