//
//  MediaItemAPIConsumable.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 04-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

protocol MediaItemAPIConsumable {
    // No importa de donde se conecte, solo tiene que responder con ese metodo
    func getLatestMediaItems() -> [MediaItemProvidable]
}