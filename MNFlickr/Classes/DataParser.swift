//
//  DataParser.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 24/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias DataParserCompletion = (_ jsonObject: JSON) -> Void

public class DataParser: NSObject {
    
    var data: Data
    var completionHandler: DataParserCompletion
    
    private override init() {
        data = Data()
        completionHandler = { json in }
    }
    
    init(withData data: Data, completionHandler: @escaping DataParserCompletion) {
        self.data = data
        self.completionHandler = completionHandler
    }

    public func parseData() {
        DispatchQueue.global(qos: .userInitiated).async {
            let json = self.parseToJSON()
            DispatchQueue.main.async {
                self.completionHandler(json)
            }
        }
    }

    private func parseToJSON() -> JSON {
        guard var dataString = String(data: data, encoding: .utf8) else { return JSON.null }
        dataString = dataString.replacingOccurrences(of: "\\'", with: "'")
        dataString = dataString.replacingOccurrences(of: "\n", with: "")
        dataString = dataString.replacingOccurrences(of: "\t", with: "")
        print(dataString)
        guard let correctData = dataString.data(using: .utf8) else { return JSON.null }
        let json = JSON(data: correctData)
        return json
    }
}

