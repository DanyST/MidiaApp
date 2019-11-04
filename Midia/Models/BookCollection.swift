//
//  BookCollection.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 31-10-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

struct BookCollection {
    
    // MARK: - Properties
    let kind: String
    let totalItems: Int
    let items: [Book]?
    
}

// MARK: - Decodable
extension BookCollection: Decodable {}
