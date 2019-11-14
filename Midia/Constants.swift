//
//  Constants.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 14-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

struct GoogleBooksAPIConstants {
    
    private static let apiKey: String = {
        guard let path = Bundle.main.path(forResource: "keys", ofType: "plist"),
            let dictKeys = NSDictionary(contentsOfFile: path),
            let apiKey = dictKeys["googleBooksAPIKey"] as? String else {
                fatalError("Google Books API Key not found")
        }
        
        return apiKey
    }()

    
    static func getAbsoluteURL(withQueryParams queryParams: [String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes"
        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        components.queryItems?.append(URLQueryItem(name: "q", value: queryParams.joined(separator: "+")))
        
        return components.url!
    }
    
}
