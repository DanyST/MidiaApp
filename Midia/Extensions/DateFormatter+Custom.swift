//
//  DateFormatter+Custom.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 02-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    // Instanciamos la constante estatica o de clase, con una clousure que se ejecuta sobre la marcha
    static let booksAPIDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter
    }()
    
    static let iTunesAPIDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return formatter
    }()
    
}
