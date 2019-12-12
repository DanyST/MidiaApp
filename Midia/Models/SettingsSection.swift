//
//  SettingsSection.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 03-12-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case mediaItemKind
    
    var description: String {
        switch self {
        case .mediaItemKind:
            return "Media Item Kind"
        }
    }
}

enum MediaItemKindOptions: Int, CaseIterable {
    case changeMediaItemKind
}
