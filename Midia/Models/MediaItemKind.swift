//
//  MediaItemKind.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 04-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import UIKit

enum MediaItemKind: Int, CaseIterable, CustomStringConvertible {
    case book
    case movie
    
    static var allCases: [MediaItemKind] {
        return [.book, .movie]
    }
    
    @available(*, unavailable)
    case game
    
    var description: String {
        switch self {
        case .book:
            return "Books"
        case .movie:
            return "Movies"
        case .game:
            return "Games"
        }
    }
    
    var imageIcon: UIImage {
        switch self {
        case .book:
            return UIImage(systemName: "book")!
        case .movie:
            return UIImage(systemName: "film")!
        case .game:
            return UIImage(systemName: "gamecontroller")!
        }
    }
}
