//
//  Extensions.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 28/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit

extension Date {
        
    static func formattedDateString(fromString dateString: String) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateformatter.date(from: dateString) {
            dateformatter.dateFormat = "dd-MM-yyyy"
            let formattedDate: String = dateformatter.string(from: date)
            return formattedDate
        }
        return ""
    }
}

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}
