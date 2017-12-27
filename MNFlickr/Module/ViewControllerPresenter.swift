//
//  ViewControllerPresenter.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 25/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit

class ViewControllerPresenter: NSObject, ViewControllerInteractorProtocol {
    
    var interactor: ViewControllerInteractor?
    
    override init() {
        super.init()
        interactor = ViewControllerInteractor(withDelegate: self)
    }
    
    public func loadFlickrImages() {
        guard let interactor = interactor else { return }
        interactor.delegate = self
        interactor.loadFlickrAPIData()
    }


    func encounterError(_ errorMessage: String) {
    
    }
    
    func succcess(message errorMessage: String) {
        print(errorMessage)
    }

}
