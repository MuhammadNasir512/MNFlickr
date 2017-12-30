//
//  ImageModel.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 27/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit
import SwiftyJSON

class ImageModel: NSObject {

    let title: String
    let published: String
    let url: String
    private var json: JSON?
    
    override var description: String {
        return "\npublished:\(published)\ntitle: \(title)\nurl:\(url)"
    }
    
    override private init() {
        title = ""; published = ""; url = ""
    }
    
    init(withJson json: JSON) {
        self.json = json
        title = json[Constants.JSONKeys.keyTitle].stringValue
        published = Date.formattedDateString(fromString: json[Constants.JSONKeys.keyPublished].stringValue)
        url = json[Constants.JSONKeys.keyMedia][Constants.JSONKeys.keyM].stringValue
        super.init()
    }
}
