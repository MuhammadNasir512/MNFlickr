//
//  RequestsManagerMock.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 30/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import XCTest
@testable import MNFlickr

class RequestsManagerMock: RequestsManager {
    
    var loadDataCallCount = 0
    var expectation: XCTestExpectation?
    var expectedDataObject: Data?
    
    override func loadData() {
        loadDataCallCount += 1
        
        let testString = "ABC"
        expectedDataObject = testString.data(using: String.Encoding.utf8)

        if let successCallback = successCallback, let data = expectedDataObject {
            successCallback(data)
            expectation?.fulfill()
        }
    }
}
