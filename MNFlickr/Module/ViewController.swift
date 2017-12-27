//
//  ViewController.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 24/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let presenter = ViewControllerPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadFlickrImages()
    }
    
}
