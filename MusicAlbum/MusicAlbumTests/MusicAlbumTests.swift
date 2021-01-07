//
//  MusicAlbumTests.swift
//  MusicAlbumTests
//
//  Created by Pedro Trujillo on 1/6/21.
//

import XCTest
@testable import MusicAlbum

class MusicAlbumTests: XCTestCase {


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testEquality(){
        var givenAlbum = MusicAlbumModel()
        givenAlbum.artistName = "The Thootless Chicken"
        givenAlbum.name = "I'm the Ruster of this Corral"
        let whenAlbumVM = MusicAlbumViewModel(model: givenAlbum)
        //then
        XCTAssertTrue(whenAlbumVM.name == "I'm the Ruster of this Corral")
        XCTAssertTrue(whenAlbumVM.artistName == "The Thootless Chicken")
    }
    

}
