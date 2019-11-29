//
//  MovieCollection.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 28-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

struct MovieCollection: Codable {
    
    // MARK: - Properties
    let resultCount: Int
    let results: [Movie]?
}
