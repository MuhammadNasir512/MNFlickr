//
//  ViewControllerInteractor.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 25/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol ViewControllerInteractorProtocol: NSObjectProtocol {
    func encounterError(_ errorMessage: String)
    func succcess(imagesArray images: [ImageModel])
}

class ViewControllerInteractor: NSObject {
    
    weak var delegate: ViewControllerInteractorProtocol?
    var requestManager = RequestsManager()
    
//    var urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"
    var urlString = "https://google.com/"

    private override init() { }
    
    init(withDelegate delegate: ViewControllerInteractorProtocol?) {
        self.delegate = delegate
    }
    
    public func loadFlickrAPIData() {
        
        requestManager.urlString = urlString
        requestManager.successCallback = { (data: Data) in
            self.parseDataToJson(data)
        }
        requestManager.failCallback = { (error: Error?, response: URLResponse?) in
            let errorMessage = error?.localizedDescription ?? "Unknown Error"
            self.delegate?.encounterError(errorMessage)
        }
        requestManager.loadData()
    }
    
    private func parseDataToJson(_ data: Data) {
        let dataParser = DataParser(
            withData: data,
            successHandler: { (json: JSON) in
                self.createImageModels(fromJSON: json)
        },
            failedHandler: { (errorMessage: String) in
                self.delegate?.encounterError(errorMessage)
        })
        dataParser.parseData()
    }
    
    private func createImageModels(fromJSON json: JSON) {
        
        guard let jsonArray = json[Constants.JSONKeys.keyItems].array else {
            self.delegate?.encounterError("Unable to parse images from json")
            return
        }
        
        var imagesArray = [ImageModel]()
        for jsonItem in jsonArray {
            let imageModel = ImageModel(withJson: jsonItem)
            imagesArray.append(imageModel)
        }
        delegate?.succcess(imagesArray: imagesArray)
    }
}
