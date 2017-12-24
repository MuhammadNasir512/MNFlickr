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
    
    var responseSuccessCallback: RequestsManagerSuccessCallback?
    var responseFailCallback: RequestsManagerFailCallback?
    var urLString: String?
    
    private override init() { }
    
    init(
        withUrlString string: String,
        successCallback: @escaping RequestsManagerSuccessCallback,
        failCallback: @escaping RequestsManagerFailCallback) {
        
        urLString = string
        responseSuccessCallback = successCallback;
        responseFailCallback = failCallback;
    }
    
    public func loadData() {
        
        guard let urLString = urLString, let url = URL(string:urLString) else { return }
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
        responseSuccessCallback?(data)
    }
    
    private func sendFailCallback(withError error: Error?, response: URLResponse?) {
        responseFailCallback?(error, response)
    }
}
