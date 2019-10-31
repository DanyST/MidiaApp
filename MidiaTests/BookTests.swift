//
//  BookTests.swift
//  MidiaTests
//
//  Created by Luis Herrera Lillo on 31-10-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import XCTest

@testable import Midia

class BookTests: XCTestCase {
    
    var bestBookEver: Book = Book(bookId: "!", title: "El nombre del viento", authors: ["Patrick Rothfuss"] , publishedDate: Date(timeIntervalSinceNow: 23312), description: "Kvothe rules", coverURL: URL(string: "http://www.google.com"), ratings: 5.0, numberOfReviews: 1, price: 10.99)

    
    func testBookExistence() {
        XCTAssertNotNil(bestBookEver)
    }

}
