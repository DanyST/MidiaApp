//
//  GoogleBooksAPIConsumerAlamofire.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 14-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation
import Alamofire

final class GoogleBooksAPIConsumerAlamofire: MediaItemAPIConsumable {
    
    func getLatestMediaItems(completion: @escaping (Swift.Result<[MediaItemProvidable], Error>) -> Void) {
        
        let url = GoogleBooksAPIConstants.getAbsoluteURL(withQueryParams: ["2019"])
        Alamofire.request(url).responseData { (response) in
            
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let bookCollection = try decoder.decode(BookCollection.self, from: data)
                    completion(.success(bookCollection.items ?? [])) // Alamofire nos envia el completion en el hilo principal
                } catch let error {
                    completion(.failure(error))  // Error parseando, lo enviamos para arriba
                }
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
            
        }
        
    }
    
    func getMediaItems(withQueryParams queryParams: String, completion: @escaping (Swift.Result<[MediaItemProvidable], Error>) -> Void) {
           
        let queryParamsList = queryParams.components(separatedBy: " ")
        
        let url = GoogleBooksAPIConstants.getAbsoluteURL(withQueryParams: queryParamsList)
        Alamofire.request(url).responseData { (response) in
            
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let bookCollection = try decoder.decode(BookCollection.self, from: data)
                    completion(.success(bookCollection.items ?? [])) // Alamofire nos envia el completion en el hilo principal
                } catch let error {
                    completion(.failure(error))  // Error parseando, lo enviamos para arriba
                }
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
            
        }
        
    }
    
}
