//
//  PhotoAlbumsTests.swift
//  PhotoAlbumsTests
//
//  Created by Peter Chambers on 16/12/2020.
//

import XCTest
@testable import PhotoAlbums

class PhotoAlbumsTests: XCTestCase {
    
    private var sut: WebService!

    override func setUpWithError() throws {
        sut = WebService()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testAPIResponse() throws {
        let expectation = XCTestExpectation(description: "Alamofire")
        sut?.getAlbums { (result) in
            switch result {
            case .success(let albums):
                XCTAssertEqual(albums.count, 100)
                expectation.fulfill()
            case .failure(let error):
                debugPrint("test failed with error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5)
    
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
