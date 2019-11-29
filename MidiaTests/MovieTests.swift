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

    override func setUp() {
        movie = Movie(movieId: 1, title: "Spider-Man: Far From Home")
    }
    
    func testMovieExistence() {
        XCTAssertNotNil(movie)
    }
    
}
