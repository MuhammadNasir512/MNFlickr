//
//  DataParser.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 24/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias DataParserSuccessful = (_ jsonObject: JSON) -> Void
typealias DataParserFailed = (_ errorMessage: String) -> Void

public class DataParser: NSObject {
    
    var data: Data
    var successHandler: DataParserSuccessful
    var failedHandler: DataParserFailed
    
    private override init() {
        data = Data()
        successHandler = { json in }
        failedHandler = { errorMessage in }
    }
    
    init(
        withData data: Data,
        successHandler: @escaping DataParserSuccessful,
        failedHandler: @escaping DataParserFailed) {
        self.data = data
        self.successHandler = successHandler
        self.failedHandler = failedHandler
    }
    
    public func parseData() {
        DispatchQueue.global(qos: .userInitiated).async {
            let json = self.parseToJSON()
            DispatchQueue.main.async {
                if json == JSON.null {
                    self.failedHandler("Failed: Invalid or Empty JSON")
                    return
                }
                self.successHandler(json)
            }
        }
    }
    
    fileprivate func parseToJSON() -> JSON {
        guard var dataString = String(data: data, encoding: .utf8) else { return JSON.null }
        dataString = dataString.replacingOccurrences(of: "\\'", with: "'")
        dataString = dataString.replacingOccurrences(of: "\n", with: "")
        dataString = dataString.replacingOccurrences(of: "\t", with: "")
        guard let correctData = dataString.data(using: .utf8) else { return JSON.null }
        let json = JSON(data: correctData)
        return json
    }
}

// This class shows how to implement another variation of data from server.
// Above class is closed for modification and open for extension as shown below.
public class XMLDataParser: DataParser {
    
    fileprivate override func parseToJSON() -> JSON {
        guard let correctData = convertToJSONFromXMLFormat(data: data) else { return JSON.null }
        let json = JSON(data: correctData)
        return json
    }
    
    private func convertToJSONFromXMLFormat(data passedData: Data) -> Data? {
        // do data conversion and return json formatted data
        return Data()
    }

}



