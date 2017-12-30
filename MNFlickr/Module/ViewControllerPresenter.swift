//
//  ViewControllerPresenter.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 25/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit

protocol ViewControllerPresenterProtocol: NSObjectProtocol {
    func encounterError(_ errorMessage: String)
    func succcess(imagesArray images: [ImageModel])
}

public class ViewControllerPresenter: NSObject, ViewControllerInteractorProtocol {
    
    weak var delegate: ViewControllerPresenterProtocol?
    var interactor: ViewControllerInteractor?
    
    private override init() { }
    
    init(withDelegate delegate: ViewControllerPresenterProtocol) {
        self.delegate = delegate
    }

    public func loadFlickrImages() {
        guard let interactor = interactor else { return }
        interactor.loadFlickrAPIData()
    }

    func encounterError(_ errorMessage: String) {
        delegate?.encounterError(errorMessage)
    }
    
    func succcess(imagesArray images: [ImageModel]) {
        delegate?.succcess(imagesArray: images)
    }
}

public class ViewControllerWithTagsPresenter: ViewControllerPresenter {
    
    public func loadFlickrImages(withTags tags: String) {
        guard let interactor = interactor as? ViewControllerWithTagsInteractor else { return }
        var tagsWithoutSpaces = tags.replacingOccurrences(of: " ", with: ",")
        tagsWithoutSpaces = tagsWithoutSpaces.replacingOccurrences(of: ".", with: ",")
        interactor.loadFlickrAPIData(withTags: tagsWithoutSpaces)
    }
    
}
