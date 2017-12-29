//
//  ViewController.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 24/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewControllerPresenterProtocol {

	var presenter: ViewControllerPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let presenter = presenter else { return }
        presenter.loadFlickrImages()
    }
    
    func encounterError(_ errorMessage: String) {
        AlertsManager.showErrorAlert(withMessage: errorMessage, inViewController: self)
    }
    
    func succcess(imagesArray images: [ImageModel]) {
//        table reload data with images array
    }
}
