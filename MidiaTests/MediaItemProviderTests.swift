//
//  MediaItemProviderTests.swift
//  MidiaTests
//
//  Created by Luis Herrera Lillo on 14-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import XCTest
@testable import Midia

final class MockMediaItemAPIConsumer: MediaItemAPIConsumable {
    func getLatestMediaItems(completion: @escaping (Result<[MediaItemProvidable], Error>) -> Void) {
        completion(.success([MockMediaItem(), MockMediaItem()]))
    }
}

final class MockMediaItem: MediaItemProvidable {
    let title: String = "A title"
    var imageURL: URL? = nil
}

class MediaItemProviderTests: XCTestCase {
    
    var mediaItemProvider: MediaItemProvider!
    var mockApiConsumer: MediaItemAPIConsumable!

    override func setUp() {
        mockApiConsumer = MockMediaItemAPIConsumer()
        mediaItemProvider = MediaItemProvider(withMediaItemKind: .book, apiConsumer: mockApiConsumer)
    }
    
    func testGetHomeMediaItems() {
        mediaItemProvider.getHomeMediaItems { (result) in
           switch result {
           case .success(let mediaItems):
               XCTAssertNotNil(mediaItems)
               XCTAssertGreaterThan(mediaItems.count, 0)
               XCTAssertEqual(mediaItems.count, 2)
               XCTAssertNotNil(mediaItems.first?.title)
               XCTAssertEqual(mediaItems.first?.title, "A title")
           case .failure(_):
               XCTFail()
           }
       }
    }


}
