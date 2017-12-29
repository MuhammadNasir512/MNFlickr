//
//  BasicAlert.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 12/29/17.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit

class BasicAlert: NSObject {
    
    let title: String
    let message: String
    
    private override init() {
        title = ""
        message = ""
        super.init()
    }
    
    init(withTitle title: String, withMessage message: String) {
        self.title = title
        self.message = message
    }
    
    public func showAlertIn(_ viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
        })
        alertController.addAction(defaultAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
