//
//  AlertsManager.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 12/29/17.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit

class AlertsManager: NSObject {
    
    public class func showErrorAlert(withMessage message: String, inViewController viewController: ViewController) {
        let alert = BasicAlert(withTitle: "Error", withMessage: message)
        alert.showAlertIn(viewController)
    }
}
