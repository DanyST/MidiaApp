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
    
    var encoder: JSONEncoder!
    var decoder: JSONDecoder!
    
    var coverURL: URL!
    var bestBookEver: Book!
    
    override func setUp() {
        super.setUp()
        
        encoder = JSONEncoder()
        decoder = JSONDecoder()
        
        coverURL = URL(string: "http://books.google.com/books/content?id=CIV8DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")
        
        bestBookEver = Book(bookId: "!", title: "El nombre del viento", authors: ["Patrick Rothfuss"] , publishedDate: Date(timeIntervalSinceNow: 23312), description: "Kvothe rules", coverURL: URL(string: "http://www.google.com"), ratings: 5.0, numberOfReviews: 1, price: 10.99)
    }

    
    func testBookExistence() {
        XCTAssertNotNil(bestBookEver)
    }
    
    func testDecodeBookCollection() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "book-search-response", ofType: "json") else {
            XCTFail()
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let bookCollection = try decoder.decode(BookCollection.self, from: data)
            XCTAssertNotNil(bookCollection)
            let firstBook = bookCollection.items?.first!
            XCTAssertNotNil(firstBook?.bookId)
            XCTAssertNotNil(firstBook?.title)
            XCTAssertNotNil(firstBook?.authors)
            XCTAssertNotNil(firstBook?.publishedDate)
            XCTAssertNotNil(firstBook?.coverURL)
        } catch {
             XCTFail()
        }
       
    }
    
    func testEncodeBook() {
        do {
            let bookData = try encoder.encode(bestBookEver)
            XCTAssertNotNil(bookData)
        } catch {
            XCTFail()
        }
    }
    
    func testDecodeEncodeDetailedBook() {
        do {
            let bookData = try encoder.encode(bestBookEver)
            XCTAssertNotNil(bookData)
            
            let book = try decoder.decode(Book.self, from: bookData)
            XCTAssertNotNil(book)
            XCTAssertNotNil(book.bookId)
            XCTAssertNotNil(book.title)
            XCTAssertNotNil(book.authors)
            XCTAssertGreaterThan(book.authors!.count, 0)
            XCTAssertNotNil(book.publishedDate)
            XCTAssertNotNil(book.description)
            XCTAssertNotNil(book.coverURL)
            XCTAssertNotNil(book.ratings)
            XCTAssertNotNil(book.numberOfReviews)
            XCTAssertNotNil(book.price)
        } catch {
            XCTFail()
        }
    }
      
}
