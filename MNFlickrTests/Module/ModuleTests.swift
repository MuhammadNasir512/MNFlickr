//
//  ModuleTests.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 30/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import XCTest
@testable import MNFlickr

public class ModuleTests: XCTestCase {
    
    func testWhenModuleObjectSetup_ThenItSetupDependenciesCorrectly() {
        let mockPresenterDelegate = MockPresenterDelegate()
        let mockInteractorDelegate = MockInteractorDelegate()
        
        let presenter = ViewControllerWithTagsPresenter(withDelegate: mockPresenterDelegate)
        let interactor = ViewControllerWithTagsInteractor(withDelegate: mockInteractorDelegate)
        
        let viewController = ViewControllerMock()
        let module = Module(withViewController: viewController)
        
        module.presenter = presenter
        module.interactor = interactor
        module.setupModule()
        
        XCTAssertEqual(viewController.presenter, presenter)
        XCTAssertEqual(presenter.interactor, interactor)
        XCTAssertNotNil(presenter.delegate)
        XCTAssertNotNil(interactor.delegate)
    }
}

