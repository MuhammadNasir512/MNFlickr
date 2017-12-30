//
//  ImageModelTests.swift
//  MNFlickrTests
//
//  Created by Muhammad Nasir on 12/29/17.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import MNFlickr

class ImageModelTests: XCTestCase {
    
    func testWhenImageModelInitWithCorrectJSON_ThenItCreatedImageObjectCorrectly() {
        
        guard let data = FixtureLoader.loadJSONObjectFromFileNamed("ImageFixture") else {
            XCTFail()
            return
        }
        
        let jsonObject = JSON(data)
        let imageModelUnderTest = ImageModel(withJson: jsonObject)
        
        XCTAssertNotNil(imageModelUnderTest)
        XCTAssertEqual(imageModelUnderTest.title, "IMG_20171224_114126419")
        XCTAssertEqual(imageModelUnderTest.url, "https://farm5.staticflickr.com/4644/24409443907_d029fdd84b_m.jpg")
        
        let publishedDateInJsonObject = jsonObject[Constants.JSONKeys.keyPublished].stringValue
        XCTAssertTrue(publishedDateInJsonObject.characters.count > 0)
        XCTAssertEqual(publishedDateInJsonObject, "2017-12-24T23:53:23Z")
        
        let formattedDateString = Date.formattedDateString(fromString: publishedDateInJsonObject)
        XCTAssertNotNil(formattedDateString)
        let dateStringExpected = "24-12-2017"
        XCTAssertEqual(imageModelUnderTest.published, dateStringExpected)
    }
    
    func testWhenImageModelInitWithIncorrectJSON_ThenItCreatedImageObjectCorrectly() {
        
        guard let data = FixtureLoader.loadJSONObjectFromFileNamed("ImageFixtureIncorrect") else {
            XCTFail()
            return
        }
        
        let jsonObject = JSON(data)
        let imageModelUnderTest = ImageModel(withJson: jsonObject)
        
        XCTAssertNotNil(imageModelUnderTest)
        XCTAssertEqual(imageModelUnderTest.title, "")
        XCTAssertEqual(imageModelUnderTest.url, "https://farm5.staticflickr.com/4644/24409443907_d029fdd84b_m.jpg")
        
        let publishedDateInJsonObject = jsonObject[Constants.JSONKeys.keyPublished].stringValue
        XCTAssertTrue(publishedDateInJsonObject.characters.count == 0)
        XCTAssertEqual(publishedDateInJsonObject, "")
        
        let formattedDateString = Date.formattedDateString(fromString: publishedDateInJsonObject)
        XCTAssertNotNil(formattedDateString)
        XCTAssertEqual(imageModelUnderTest.published, "")
    }

}
