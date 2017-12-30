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
    var presenter: ViewControllerPresenter?
    var interactor: ViewControllerInteractor?
    
    private override init() { }
    
    init(withViewController viewController: ViewController) {
        self.viewController = viewController
    }
    
    public func setupModule() {
        guard
            let viewController = viewController,
            let presenter = presenter,
            let interactor = interactor
            
            else { return }
        
        viewController.presenter = presenter
        presenter.interactor = interactor
    }
}
