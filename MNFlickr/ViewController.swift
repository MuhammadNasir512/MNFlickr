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
        
        let urLString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"
        let requestManager = RequestsManager(
            withUrlString: urLString, successCallback: { (data: Data) in
                
                guard var dataString = String(data: data, encoding: .utf8) else { return }
                dataString = dataString.replacingOccurrences(of: "\\'", with: "'")
                dataString = dataString.replacingOccurrences(of: "\n", with: "")
                dataString = dataString.replacingOccurrences(of: "\t", with: "")
                guard let correctData = dataString.data(using: .utf8) else { return }
                let json = JSON(data: correctData)
                print("AAAAA:\(json)")
//                print("\(dataString)")
        },
            failCallback: { (error: Error?, response: URLResponse?) in
                print("ERROR:\(error?.localizedDescription)")
                print("response:\(response)")
        })
        requestManager.loadData()
    }
}

