//
//  RequestsManager.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 24/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit

typealias RequestsManagerSuccessCallback = (_ data: Data) -> Void
typealias RequestsManagerFailCallback = (_ error: Error?, _ response: URLResponse?) -> Void

class RequestsManager: NSObject {
    
    var successCallback: RequestsManagerSuccessCallback?
    var failCallback: RequestsManagerFailCallback?
    var urlString: String?
    
    public func loadData() {
        
        guard let urLString = urlString, let url = URL(string:urLString) else { return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let data = data {
                    self.sendSuccessCallback(withData: data)
                }
                else {
                    self.sendFailCallback(withError: error, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    private func sendSuccessCallback(withData data: Data) {
        successCallback?(data)
    }
    
    private func sendFailCallback(withError error: Error?, response: URLResponse?) {
        failCallback?(error, response)
    }
}
