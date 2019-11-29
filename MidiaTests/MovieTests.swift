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
    
    var coverURL: URL!
    var movie: Movie!

    override func setUp() {
        decoder = JSONDecoder()
        
        coverURL = URL(string: "https://is4-ssl.mzstatic.com/image/thumb/Video118/v4/5f/e3/74/5fe3749a-bc9b-f129-53e0-649c7c487fa0/source/100x100bb.jpg")
        movie = Movie(movieId: "1", title: "Spider-Man: Far From Home", directors: ["Jon Watts"], releaseDate: Date(timeIntervalSinceNow: 23312), description: "", coverURL: coverURL, ratings: 5, numberOfReviews: 10, price: 5.99)
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

}
