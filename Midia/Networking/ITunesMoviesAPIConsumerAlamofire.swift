//
//  ITunesMoviesAPIConsumerAlamofire.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 30-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation
import Alamofire

final class ITunesMoviesAPIConsumerAlamofire: MediaItemAPIConsumable {
    
    private let decoder = JSONDecoder()
    
    func getLatestMediaItems(completion: @escaping (Swift.Result<[MediaItemProvidable], Error>) -> Void) {
        
        let url = ITunesMoviesAPIConstants.getAbsoluteURL(withQueryParams: ["trending"])
        Alamofire.request(url).responseData { [unowned self] (response) in
            
            switch response.result {
            case .success(let data):
                do {
                    let moviesCollection = try self.decoder.decode(MovieCollection.self, from: data)
                    completion(.success(moviesCollection.results ?? []))
                } catch let error {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    func getMediaItems(withQueryParams queryParams: String, completion: @escaping (Swift.Result<[MediaItemProvidable], Error>) -> Void) {
        
        let queryParams = queryParams.components(separatedBy: " ")
        let url = ITunesMoviesAPIConstants.getAbsoluteURL(withQueryParams: queryParams)
        
        Alamofire.request(url).responseData { [unowned self] (response) in
            
            switch response.result {
            case .success(let data):
                do {
                    let movieCollection = try self.decoder.decode(MovieCollection.self, from: data)
                    completion(.success(movieCollection.results ?? []))
                } catch let error {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMediaItem(byId mediaItemId: String, completion: @escaping (Swift.Result<MediaItemDetailedProvidable, Error>) -> Void) {
        
        let url = ITunesMoviesAPIConstants.urlForMovie(withId: mediaItemId)
        Alamofire.request(url).responseData { [unowned self] (response) in
            
            switch response.result {
            case .success(let data):
                do {
                    let movieCollection = try self.decoder.decode(MovieCollection.self, from: data)
                    
                    if let movie = movieCollection.results?.first {
                        completion(.success(movie))
                    } else {
                        let errorNotFound = NSError(domain: "Media item Not Found", code: 404)
                        completion(.failure(errorNotFound))
                    }
                    
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
