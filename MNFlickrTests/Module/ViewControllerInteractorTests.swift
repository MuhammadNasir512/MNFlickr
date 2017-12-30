//
//  ViewControllerInteractorTests.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 30/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import XCTest
@testable import MNFlickr

class ViewControllerInteractorTests: XCTestCase {
    
    func testExample() {
        
        let requestManagerMock = RequestsManagerMock()
        let fakeInteractorDelegate = MockInteractorDelegate()
        let interactorUnderTest = ViewControllerInteractor(withDelegate: fakeInteractorDelegate)
        interactorUnderTest.urlString = "https://google.com/"
        interactorUnderTest.requestManager = requestManagerMock

        let expect = expectation(description: "Expectation")
        requestManagerMock.expectation = expect
        interactorUnderTest.loadFlickrAPIData()
        
        waitForExpectations(timeout: 5) { error in
            let data = requestManagerMock.expectedDataObject
            XCTAssertNotNil(data)
            
            if let dataUnwrapped = data, let string = String(data: dataUnwrapped, encoding: String.Encoding.utf8) as String? {
                XCTAssertTrue(string.characters.count == 3)
                XCTAssertEqual(string, "ABC")
            }
            else {
                XCTFail("Unexpected data value")
            }
        }
    }
    
}
