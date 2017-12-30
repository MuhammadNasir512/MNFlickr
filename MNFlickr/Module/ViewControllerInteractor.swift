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

public class ViewControllerInteractor: NSObject {
    
    weak var delegate: ViewControllerInteractorProtocol?
    var requestManager = RequestsManager()
    var urlString = Constants.APIURL

    private override init() { }
    
    init(withDelegate delegate: ViewControllerInteractorProtocol?) {
        self.delegate = delegate
    }
    
    public func loadFlickrAPIData() {
        
        requestManager.urlString = urlString
        requestManager.successCallback = { (data: Data) in
            self.urlString = Constants.APIURL
            self.parseDataToJson(data)
        }
        requestManager.failCallback = { (error: Error?, response: URLResponse?) in
            self.urlString = Constants.APIURL
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

public class ViewControllerWithTagsInteractor: ViewControllerInteractor {
    public func loadFlickrAPIData(withTags tags: String) {
        urlString = "\(urlString)&tags=\(tags)"
        super.loadFlickrAPIData()
    }
}
