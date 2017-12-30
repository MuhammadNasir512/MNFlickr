//
//  MockPresenterDelegate.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 30/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit
import XCTest
@testable import MNFlickr

public class MockPresenterDelegate: NSObject, ViewControllerPresenterProtocol {
    
    var fakeImages: [ImageModel]?
    var expectation: XCTestExpectation?
    public func encounterError(_ errorMessage: String) { }
    
    public func succcess(imagesArray images: [ImageModel]) {
        fakeImages = images
        expectation?.fulfill()
    }
}
