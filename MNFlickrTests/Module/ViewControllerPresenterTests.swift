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
        let fakeInteractorDelegate = MockInteractorDelegate()
        let interactorMock = ViewControllerInteractorMock(withDelegate: fakeInteractorDelegate)
        let fakePresenterDelegate = MockPresenterDelegate()
        let presenterUnderTest = ViewControllerWithTagsPresenter(withDelegate: fakePresenterDelegate)
        
        let presenterExpectation = expectation(description: "presenterExpectation")
        fakePresenterDelegate.expectation = presenterExpectation
        let interactorExpectation = expectation(description: "interactorExpectation")
        fakeInteractorDelegate.expectation = interactorExpectation
        
        let tags = "landscape"
        presenterUnderTest.interactor = interactorMock
        presenterUnderTest.loadFlickrImages(withTags: tags)
        
        let result = XCTWaiter().wait(for: [presenterExpectation, interactorExpectation], timeout: 4, enforceOrder: true)
        if result == .completed {
            guard let result = fakePresenterDelegate.fakeImages else {
                XCTFail("Expected delegate to be called")
                return
            }
            XCTAssertTrue(result.count == 0)
            XCTAssertTrue(interactorMock.loadFlickrAPIDataCallCount == 1)
        }
    }
    
    func testWhenLoadImagesMethodCalled_AndThereWereSomeImages_ThenItReturnThoseImages() {
        let imagesToFake = 5
        let fakeInteractorDelegate = MockInteractorDelegate()
        let interactorMock = ViewControllerInteractorMock(withDelegate: fakeInteractorDelegate)
        let fakePresenterDelegate = MockPresenterDelegate()
        let presenterUnderTest = ViewControllerWithTagsPresenter(withDelegate: fakePresenterDelegate)
        
        let presenterExpectation = expectation(description: "presenterExpectation")
        fakePresenterDelegate.expectation = presenterExpectation
        let interactorExpectation = expectation(description: "interactorExpectation")
        fakeInteractorDelegate.expectation = interactorExpectation
        
        let tags = "landscape"
        presenterUnderTest.interactor = interactorMock
        presenterUnderTest.loadFlickrImages(withTags: tags)
        
        let result = XCTWaiter().wait(for: [presenterExpectation, interactorExpectation], timeout: 4, enforceOrder: true)
        if result == .completed {
            guard let result = fakePresenterDelegate.fakeImages else {
                XCTFail("Expected delegate to be called")
                return
            }
            XCTAssertTrue(result.count == imagesToFake)
            XCTAssertTrue(interactorMock.loadFlickrAPIDataCallCount == 1)
        }
    }
}

