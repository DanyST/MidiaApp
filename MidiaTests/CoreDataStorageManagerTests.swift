//
//  CoreDataStorageManagerTests.swift
//  MidiaTests
//
//  Created by Luis Herrera Lillo on 11-12-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import XCTest
import CoreData
@testable import Midia

class CoreDataStorageManagerTests: XCTestCase {
    
    var bestBookEver: Book!
    var bestMovieEver: Movie!
    
    var coreDataStackForTests: CoreDataStackProvidable!
    var coreDataStorageManagerBook: FavoritesProvidable!
    var coreDataStorageManagerMovie: FavoritesProvidable!

    override func setUp() {
        super.setUp()
        
        // Instance Media Items
        bestMovieEver = Movie(movieId: "1", title: "Spider-Man: Far From Home", directors: ["Jon Watts"], releaseDate: Date(timeIntervalSinceNow: 23312), description: "Amazing", coverURL: nil, price: 5.99)
        
         bestBookEver = Book(bookId: "1", title: "El nombre del viento", authors: ["Patrick Rothfuss"] , publishedDate: Date(timeIntervalSinceNow: 23312), description: "Kvothe rules", coverURL: nil, ratings: 5.0, numberOfReviews: 1, price: 10.99)
        
         // CoreData
        coreDataStackForTests = CoreDataTestStack()

        // Instance CoreData Manager for Movie and Book
        coreDataStorageManagerBook = CoreDataStorageManager(withMediaItemKind: .book, coreDataStack: coreDataStackForTests)
        coreDataStorageManagerMovie = CoreDataStorageManager(withMediaItemKind: .movie, coreDataStack: coreDataStackForTests)
        
    }

    func testStorageManagerExistence() {
        XCTAssertNotNil(coreDataStorageManagerBook)
        XCTAssertNotNil(coreDataStorageManagerMovie)
    }
    
    // Given When Then
    func testPersistOnCoreDataManager_AddFavoriteBook_ReturnValidItem() {
                
        coreDataStorageManagerBook.add(favorite: bestBookEver)
        
        let book = coreDataStorageManagerBook.getFavorite(byId: bestBookEver.bookId)
        
        XCTAssertNotNil(book)
        
        XCTAssertEqual(book?.mediaItemId, bestBookEver.bookId)
        XCTAssertEqual(book?.title, bestBookEver.title)
        
        // other book
        let bestBookEver2 = Book(bookId: "2", title: "El nombre del viento 2", authors: ["Patrick Rothfuss"] , publishedDate: Date(timeIntervalSinceNow: 23312), description: "Kvothe rules", coverURL: nil, ratings: 5.0, numberOfReviews: 1, price: 10.99)
        
        coreDataStorageManagerBook.add(favorite: bestBookEver2)
        let book2 = coreDataStorageManagerBook.getFavorite(byId: bestBookEver2.bookId)
        
        XCTAssertEqual(book2?.mediaItemId, bestBookEver2.bookId)
        XCTAssertEqual(book2?.title, bestBookEver2.title)
    }
    
    func testPersistOnCoreDataManager_RemoveFavoriteBook_ReturnEmptyArray() {
        
        coreDataStorageManagerBook.add(favorite: bestBookEver)

        coreDataStorageManagerBook.remove(favoriteWithId: bestBookEver.mediaItemId)

        let favorites = coreDataStorageManagerBook.getFavorites()
        
        XCTAssertTrue(favorites!.isEmpty)
    }
    
    // Given When Then
    func testPersistOnCoreDataManager_AddFavoriteMovie_ReturnValidItem() {
        
        coreDataStorageManagerMovie.add(favorite: bestMovieEver)

        let movie = coreDataStorageManagerMovie.getFavorite(byId: bestMovieEver.movieId)

        XCTAssertNotNil(movie)

        XCTAssertEqual(movie?.mediaItemId, bestMovieEver.movieId)
        XCTAssertEqual(movie?.title, bestMovieEver.title)
        
        // other book
        let bestMovieEver2 = Movie(movieId: "2", title: "Spider-Man: Homecoming", directors: ["Jon Watts"], releaseDate: Date(timeIntervalSinceNow: 23312), description: "Amazing", coverURL: nil, price: 5.99)
        
        coreDataStorageManagerMovie.add(favorite: bestMovieEver2)

        let movie2 = coreDataStorageManagerMovie.getFavorite(byId: bestMovieEver2.movieId)

        XCTAssertNotNil(movie2)

        XCTAssertEqual(movie2?.mediaItemId, bestMovieEver2.movieId)
        XCTAssertEqual(movie2?.title, bestMovieEver2.title)
    }
    
    func testPersistOnCoreDataManager_RemoveFavoriteMovie_ReturnEmptyArray() {
        
        coreDataStorageManagerMovie.add(favorite: bestMovieEver)

        coreDataStorageManagerMovie.remove(favoriteWithId: bestMovieEver.mediaItemId)

        let favorites = coreDataStorageManagerMovie.getFavorites()

        XCTAssertTrue(favorites!.isEmpty)
    }


}
