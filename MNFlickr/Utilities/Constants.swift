//
//  Constants.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 28/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import Foundation

public class Constants {
    
    static let APIURL = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"
    struct JSONKeys {
        static let keyItems = "items"
        static let keyTitle = "title"
        static let keyPublished = "published"
        static let keyMedia = "media"
        static let keyM = "m"
    }
}

