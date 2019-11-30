//
//  ITunesMoviesAPIConsumerURLSession.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 30-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation

final class ITunesMoviesAPIConsumerURLSession: MediaItemAPIConsumable {
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    func getLatestMediaItems(completion: @escaping (Result<[MediaItemProvidable], Error>) -> Void) {
        
        let url = ITunesMoviesAPIConstants.getAbsoluteURL(withQueryParams: ["top"])
        let task = session.dataTask(with: url) { [unowned self] (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async { completion(.success([])) }
                return
            }
            
            do {
                let movieCollection = try self.decoder.decode(MovieCollection.self, from: data)
                DispatchQueue.main.async { completion(.success(movieCollection.results ?? [])) }
            } catch let error {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
        
        task.resume()
    }
    
    func getMediaItems(withQueryParams queryParams: String, completion: @escaping (Result<[MediaItemProvidable], Error>) -> Void) {
        
        let queryParams = queryParams.components(separatedBy: " ")
        let url = ITunesMoviesAPIConstants.getAbsoluteURL(withQueryParams: queryParams)
        
        let task = session.dataTask(with: url) { [unowned self] (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async { completion(.success([])) }
                return
            }
            
            do {
                let movieCollection = try self.decoder.decode(MovieCollection.self, from: data)
                DispatchQueue.main.async { completion(.success(movieCollection.results ?? [])) }
            } catch let error {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
        
        task.resume()
    }
    
    func getMediaItem(byId mediaItemId: String, completion: @escaping (Result<MediaItemDetailedProvidable, Error>) -> Void) {
        
        let url = ITunesMoviesAPIConstants.urlForMovie(withId: mediaItemId)
        let task = session.dataTask(with: url) { [unowned self] (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            
            // 404 error constant
            let notFoundError = NSError(domain: "Media item not found", code: 404)
            
            // Data not nil verify
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(notFoundError)) }
                return
            }
            
            do {
                let movieCollection = try self.decoder.decode(MovieCollection.self, from: data)
                
                // API always retrieve an array
                if let movie = movieCollection.results?.first {
                    DispatchQueue.main.async { completion(.success(movie)) }
                } else {
                    DispatchQueue.main.async { completion(.failure(notFoundError)) }
                }
                
            } catch let error {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
            
        }
        
        task.resume()
    }
    
}
