//
//  ViewControllerInteractorMock.swift
//  MNFlickrTests
//
//  Created by Muhammad Nasir on 12/29/17.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit
import SwiftyJSON
@testable import MNFlickr

class ViewControllerInteractorMock: ViewControllerInteractor {
    
    var loadFlickrAPIDataCallCount = 0
    var numberOfImagesToReturn = 0
    
    override func loadFlickrAPIData() {
        loadFlickrAPIDataCallCount += 1
        let imagesArray = fakeImagesArray()
        delegate?.succcess(imagesArray: imagesArray)
    }
    
    private func fakeImagesArray() -> [ImageModel] {
        var images = [ImageModel]()
        for _ in 0..<numberOfImagesToReturn {
            let oneImage = ImageModel(withJson: fakeImageJson())
            images.append(oneImage)
        }
        return images
    }
    
    private func fakeImageJson() -> JSON {
        guard let data = FixtureLoader.loadJSONObjectFromFileNamed("ImageFixture") else {
            return JSON.null
        }
        return JSON(data)
    }
}
