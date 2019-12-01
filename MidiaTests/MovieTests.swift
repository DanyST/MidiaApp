//
//  MovieTests.swift
//  MidiaTests
//
//  Created by Luis Herrera Lillo on 28-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import XCTest
@testable import Midia

class MovieTests: XCTestCase {
    var decoder: JSONDecoder!
    var encoder: JSONEncoder!
    
    var coverURL: URL!
    var movie: Movie!

    override func setUp() {
        decoder = JSONDecoder()
        encoder = JSONEncoder()
        
        coverURL = URL(string: "https://is4-ssl.mzstatic.com/image/thumb/Video118/v4/5f/e3/74/5fe3749a-bc9b-f129-53e0-649c7c487fa0/source/100x100bb.jpg")
        movie = Movie(movieId: "1", title: "Spider-Man: Far From Home", directors: ["Jon Watts"], releaseDate: Date(timeIntervalSinceNow: 23312), description: "Amazing", coverURL: coverURL, price: 5.99)
    }
    
    func testMovieExistence() {
        XCTAssertNotNil(movie)
    }
    
    func testDecodeMovieCollection() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "movie-search-response", ofType: "json") else {
            XCTFail()
            return
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let movieCollection = try decoder.decode(MovieCollection.self, from: data)
            XCTAssertNotNil(movieCollection)
            let firstMovie = movieCollection.results?.first
            XCTAssertNotNil(firstMovie)
            XCTAssertNotNil(firstMovie?.movieId)
            XCTAssertNotNil(firstMovie?.title)
        } catch {
            XCTFail()
        }
    }
    
    func testEncodeMovie() {
        do {
            let movieData = try encoder.encode(movie)
            XCTAssertNotNil(movieData)
        } catch {
            XCTFail()
        }
    }
    
    func testDecodeEncodeDetailedMovie() {
        do {
            let movieData = try encoder.encode(movie)
            XCTAssertNotNil(movieData)

            let movie = try decoder.decode(Movie.self, from: movieData)
            XCTAssertNotNil(movie)

            XCTAssertNotNil(movie.movieId)
            XCTAssertNotNil(movie.title)
            XCTAssertNotNil(movie.directors)
            XCTAssertEqual(movie.directors?.count, 1)
            XCTAssertNotNil(movie.releaseDate)
            XCTAssertNotNil(movie.description)
            XCTAssertNotNil(movie.coverURL)
            
        } catch {
            XCTFail()
        }
    }
    
    func testPersistOnUserDefaults() {
        let userDefaults = UserDefaults(suiteName: "tests")!
        let movieKey = "movieKey"
        
        do {
            let movieData = try encoder.encode(movie)
            userDefaults.set(movieData, forKey: movieKey)
            userDefaults.synchronize()
            
            guard let retrieveMovieData = userDefaults.data(forKey: movieKey) else {
                XCTFail()
                return
            }
            
            let movie = try decoder.decode(Movie.self, from: retrieveMovieData)
            XCTAssertNotNil(movie)
                        
        } catch  {
            XCTFail()
        }
       
    }

}
