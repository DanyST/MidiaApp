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
    
    var movie: Movie!
    var decoder: JSONDecoder!

    override func setUp() {
        decoder = JSONDecoder()
        movie = Movie(movieId: 1, title: "Spider-Man: Far From Home")
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
