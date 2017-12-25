//
//  ViewController.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 24/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFlickrAPIData()
    }
    
    fileprivate func parseData(_ data: Data) {
        parseDataToJson(data)
    }
    
    fileprivate func createImageModels(fromJSON json: JSON) {
        print("AAAAA:\(json)")
    }
    
    fileprivate func presentErrorToUser(withMessage message: String) {
        print("ERROR: \(message)")
    }
}

extension ViewController {
    
    fileprivate func loadFlickrAPIData() {
        let urLString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"
        let requestManager = RequestsManager(
            withUrlString: urLString, successCallback: { (data: Data) in
                self.parseData(data)
        },
            failCallback: { (error: Error?, response: URLResponse?) in
                print("ERROR:\(error?.localizedDescription)")
                print("response:\(response)")
        })
        requestManager.loadData()
    }
}

extension ViewController {
    
    fileprivate func parseDataToJson(_ data: Data) {
        let dataParser = DataParser(withData: data, completionHandler: { (json) in
            self.createImageModels(fromJSON: json)
        })
        dataParser.parseData()
    }
}
