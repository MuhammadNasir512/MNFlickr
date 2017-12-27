//
//  DataParserTests.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 24/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import MNFlickr

class DataParserTests: XCTestCase {
    
    func testWhenEmptyDataBeingParsed_ThenJsonObjectIsNull() {
        let expect = expectation(description: "Expectation")
        
        let data = Data()
        let dataParser = DataParser(
            withData: data,
            successHandler: { (json: JSON) in
                expect.fulfill()
                XCTFail()
        },
            failedHandler: { (errorMessage: String) in
                expect.fulfill()
                XCTAssertEqual(errorMessage, "Failed: Invalid or Empty JSON")
        })
        
        dataParser.parseData()
        waitForExpectations(timeout: 10) { error in }
        
    }
    
    func testWhenDataIsNotWellFormedJSON_ThenJsonObjectIsNull() {
        let expect = expectation(description: "Expectation")
        
        let string = "NOt a valid JSON"
        guard let data = string.data(using: .utf8) else {
            XCTFail()
            return
        }
        let dataParser = DataParser(
            withData: data,
            successHandler: { (json: JSON) in
                expect.fulfill()
                XCTFail()
        },
            failedHandler: { (errorMessage: String) in
                expect.fulfill()
                XCTAssertEqual(errorMessage, "Failed: Invalid or Empty JSON")
        })
        dataParser.parseData()
        waitForExpectations(timeout: 4) { error in }
        
    }
    
    func testWhenDataIsWellFormedJSON_ThenJsonObjectIsValid() {
        
        let expect = expectation(description: "Expectation")
        
        guard let data = FixtureLoader.loadJSONObjectFromFileNamed("FlickrFixture") else {
            XCTFail()
            return
        }
        
        let dataParser = DataParser(
            withData: data,
            successHandler: { (json: JSON) in
                expect.fulfill()
                self.doTestsOn(json: json)
        },
            failedHandler: { (errorMessage: String) in
                expect.fulfill()
                XCTFail()
        })
        dataParser.parseData()
        waitForExpectations(timeout: 4) { error in }
    }
    
    private func doTestsOn(json jsonObject: JSON) {
        
        XCTAssertTrue(JSON.null != jsonObject)
        
        let jsonArray = jsonObject["items"]
        XCTAssertTrue(JSON.null != jsonArray)
        XCTAssertEqual(jsonArray.arrayValue.count, 20)
        
        let firstItem = jsonArray[0]
        XCTAssertTrue(JSON.null != firstItem)
        
        let firstITemAuthorId = firstItem["author_id"]
        XCTAssertEqual(firstITemAuthorId, "93931621@N03")
        
        let mediaObjectFirstItem = firstItem["media"]["m"]
        XCTAssertTrue(JSON.null != mediaObjectFirstItem)
        XCTAssertEqual(mediaObjectFirstItem, "https://farm5.staticflickr.com/4644/24409443907_d029fdd84b_m.jpg")
    }
}
