//
//  ViewControllerPresenterTests.swift
//  MNFlickrTests
//
//  Created by Muhammad Nasir on 12/29/17.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import XCTest
@testable import MNFlickr

class ViewControllerPresenterTests: XCTestCase {
    
    func testWhenLoadImagesMethodCalled_AndThereWereNoImages_ThenItReturnNoImages() {
        let interactorMock = ViewControllerInteractorMock(withDelegate: nil)
        let fakeDelegate = MockPresenterDelegate()
        let presenterUnderTest = ViewControllerPresenter(withDelegate: fakeDelegate)
        
        let expect = expectation(description: "Expectation")
        fakeDelegate.expectation = expect
        
        presenterUnderTest.interactor = interactorMock
        presenterUnderTest.loadFlickrImages()
        
        waitForExpectations(timeout: 5) { error in
            guard let result = fakeDelegate.fakeImages else {
                XCTFail("Expected delegate to be called")
                return
            }
            XCTAssertTrue(result.count == 0)
            XCTAssertTrue(interactorMock.loadFlickrAPIDataCallCount == 1)
        }
    }
    
    func testWhenLoadImagesMethodCalled_AndThereWereSomeImages_ThenItReturnThoseImages() {
        let imagesToFake = 5
        let interactorMock = ViewControllerInteractorMock(withDelegate: nil)
        interactorMock.numberOfImagesToReturn = imagesToFake
        let fakeDelegate = MockPresenterDelegate()
        let presenterUnderTest = ViewControllerPresenter(withDelegate: fakeDelegate)
        
        let expect = expectation(description: "Expectation")
        fakeDelegate.expectation = expect
        
        presenterUnderTest.interactor = interactorMock
        presenterUnderTest.loadFlickrImages()
        
        waitForExpectations(timeout: 4) { error in
            guard let result = fakeDelegate.fakeImages else {
                XCTFail("Expected delegate to be called")
                return
            }
            XCTAssertTrue(result.count == imagesToFake)
            XCTAssertTrue(interactorMock.loadFlickrAPIDataCallCount == 1)
        }
    }
}

