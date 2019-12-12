//
//  MovieManaged+Mapping.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 01-12-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation
import CoreData

// MARK: Constants
extension MovieManaged {
    static let entityName: String = "Movie"
}

// MARK: Methods
extension MovieManaged {
    
    func mappedObject() -> Movie {
       let directors: [String]? = {
           guard let directorsArray = self.directors?.allObjects as? [Director], !directorsArray.isEmpty else { return nil }
           let creatorsName = directorsArray.map { $0.fullName! } // fullName is required in dataModel
           return creatorsName
       }()
       
       let url: URL? = try? coverURL?.asURL()
       let price: Float? = self.price > 0 ? self.price : nil
       let rating: Float? = self.rating > 0 ? self.rating : nil
       
       let movie = Movie(movieId: movieId!, title: title!, directors: directors, releaseDate: releaseDate, description: movieDescription, coverURL: url, ratings: rating, numberOfReviews: Int(numberOfReviews), price: price)
       
       return movie
    }
}

// MARK: Init Convenience with movie
extension MovieManaged {
    
    convenience init(withMediaItemMovie mediaItemMovie: Movie, context: NSManagedObjectContext) {
        // NSEntityDescription de MovieManaged
        guard let movie = NSEntityDescription.entity(forEntityName: MovieManaged.entityName, in: context) else {
            fatalError("invalid entity name string: \(MovieManaged.entityName)")
        }

        // Init designado
        self.init(entity: movie, insertInto: context)

        // Darle valor a las propiedades de la instancia self
        self.movieId = mediaItemMovie.movieId
        self.title = mediaItemMovie.title
        self.movieDescription = mediaItemMovie.description
        self.releaseDate = mediaItemMovie.releaseDate
        self.coverURL = mediaItemMovie.imageURL?.absoluteString

        if let numberOfReviews = mediaItemMovie.numberOfReviews {
            self.numberOfReviews = Int32(numberOfReviews)
        }

        if let rating = mediaItemMovie.ratings {
            self.rating = rating
        }

        if let price = mediaItemMovie.price {
            self.price = price
        }

            
        mediaItemMovie.directors?.forEach({ directorName in
            // Crear el una instancia de director
            let director = Director(context: context)

            // Darle valor
            director.fullName = directorName

            // Añadirlo a la lista de authors de self
            self.addToDirectors(director)
        })
    }
}
