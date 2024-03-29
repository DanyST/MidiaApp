//
//  MediaItemProvidable.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 04-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

protocol MediaItemProvidable {
    
    var mediaItemId: String { get }
    var title: String { get }
    var imageURL: URL? { get }
    
}
