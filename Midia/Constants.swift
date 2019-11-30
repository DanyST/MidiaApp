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
    
    private static func baseURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        
        return components
    }
    
    static func getAbsoluteURL(withQueryParams queryParams: [String]) -> URL {
        var components = baseURLComponents()
        components.path = "/books/v1/volumes"
        components.queryItems?.append(URLQueryItem(name: "q", value: queryParams.joined(separator: "+")))
        
        return components.url!
    }
    
    static func urlForBook(withId bookId: String) -> URL {
        var components = baseURLComponents()
        components.path = "/books/v1/volumes/\(bookId)"
        
        return components.url!
    }
}

struct ITunesMoviesAPIConstants {
    
    private static func baseURLComponents() -> URLComponents{
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        
        return components
    }
    
    static func getAbsoluteURL(withQueryParams queryParams: [String], country: String = "US") -> URL {
        var components = baseURLComponents()
        components.path = "/search"
        components.queryItems = [
            URLQueryItem(name: "media", value: "movie"),
            URLQueryItem(name: "attribute", value: "movieTerm"),
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "term", value: queryParams.joined(separator: "+"))
        ]
        
        return components.url!
    }
    
    static func urlForMovie(withId movieId: String, country: String = "US") -> URL {
        var components = baseURLComponents()
        components.path = "/lookup"
        components.queryItems = [
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "id", value: movieId)
        ]
        
        return components.url!
    }
}
