//
//  ExtensionsTests.swift
//  MNFlickrTests
//
//  Created by Muhammad Nasir on 12/29/17.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import XCTest
@testable import MNFlickr

class ExtensionsTests: XCTestCase {
    
    func testWhenDateIsProvidedInSpecificFormat_ThenItConvertsItToDesiredFormat() {
        
        var dateStringInput = "2017-12-24T23:53:37Z"
        var formattedDateString = Date.formattedDateString(fromString: dateStringInput)

        XCTAssertNotNil(formattedDateString)
        var dateStringExpected = "24-12-2017"
        XCTAssertEqual(formattedDateString, dateStringExpected)
        
        dateStringInput = "2017-12-24T15:53:37-08:00"
        formattedDateString = Date.formattedDateString(fromString: dateStringInput)
        dateStringExpected = "24-12-2017"
        XCTAssertEqual(formattedDateString, dateStringExpected)
    }
}
