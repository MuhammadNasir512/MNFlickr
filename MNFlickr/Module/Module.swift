//
//  Module.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 12/29/17.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit

class Module: NSObject {
    
    var viewController: ViewController?
    
    private override init() { }
    
    init(withViewController viewController: ViewController) {
        self.viewController = viewController
    }
    
    public func setupModule() {
        guard let viewController = viewController else { return }
        let presenter = ViewControllerPresenter(withDelegate: viewController)
        let interactor = ViewControllerInteractor(withDelegate: presenter)
        viewController.presenter = presenter
        presenter.interactor = interactor
    }
}
