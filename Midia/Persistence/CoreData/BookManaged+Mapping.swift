//
//  BookManaged+Mapping.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 26-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation
import CoreData

extension BookManaged {
    
    func mappedObject() -> Book {
        let authors: [String]? = {
            // TODO: validar authors con mas de 0 elementos
            guard let authorsArray = self.authors?.allObjects as? [Author], !authorsArray.isEmpty else { return nil }
            let creatorsName = authorsArray.map { $0.fullName! } // fullName is required in dataModel
            return creatorsName
        }()
        
        let url: URL? = try? coverURL?.asURL()
        let price: Float? = self.price > 0 ? self.price : nil
        let rating: Float? = self.rating > 0 ? self.rating : nil
        
        let book = Book(bookId: bookId!, title: title!, authors: authors, publishedDate: publishedDate, description: bookDescription, coverURL: url, ratings: rating, numberOfReviews: Int(numberOfReviews), price: price)
        
        return book
    }
    
    convenience init(withMediaItemBook mediaItemBook: Book, context: NSManagedObjectContext) {
        // NSEntityDescription de BookManaged
        let book = BookManaged.entity()
        
        // Init designado
        self.init(entity: book, insertInto: context)
        
        // Darle valor a las propiedades de la instancia self
        self.bookId = mediaItemBook.bookId
        self.title = mediaItemBook.title
        self.bookDescription = mediaItemBook.description
        self.publishedDate = mediaItemBook.publishedDate
        self.coverURL = mediaItemBook.imageURL?.absoluteString
        
        if let numberOfReviews = mediaItemBook.numberOfReviews {
            self.numberOfReviews = Int32(numberOfReviews)
        }
        
        if let rating = mediaItemBook.ratings {
            self.rating = rating
        }
        
        if let price = mediaItemBook.price {
            self.price = price
        }

        mediaItemBook.authors?.forEach({ authorName in
            // Crear el una instancia de author
            let author = Author(context: context)
            
            // Darle valor
            author.fullName = authorName
            
            // Añadirlo a la lista de authors de self
            self.addToAuthors(author)
        })
    }
    
}
