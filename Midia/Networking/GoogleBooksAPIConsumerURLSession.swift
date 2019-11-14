//
//  GoogleBooksAPIConsumerURLSession.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 14-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

class GoogleBooksAPIConsumerURLSession: MediaItemAPIConsumable {
    
    let session = URLSession.shared
    let apiKey = ""
    
    func getAbsoluteURL(withQueryParams queryParams: [String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes"
        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        components.queryItems?.append(URLQueryItem(name: "q", value: queryParams.joined(separator: "+")))
        
        return components.url!
    }
    
    func getLatestMediaItems(completion: @escaping (Result<[MediaItemProvidable], Error>) -> Void) {
        let url = getAbsoluteURL(withQueryParams: ["2019"])
        let task = session.dataTask(with: url) { (data, response, error) in
            // Si hay error, lo paso para arriba con la clousure en failure type
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let bookCollection = try decoder.decode(BookCollection.self, from: data)
                    DispatchQueue.main.async { completion(.success(bookCollection.items ?? [])) }
                } catch let error {
                    DispatchQueue.main.async { completion(.failure(error)) }  // Error parseando, lo enviamos para arriba
                }
               
            } else {
                DispatchQueue.main.async { completion(.success([])) }
            }
        }
        
        task.resume()
    }
    
    
}
