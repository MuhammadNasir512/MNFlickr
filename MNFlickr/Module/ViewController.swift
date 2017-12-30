//
//  ViewController.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 24/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit

public class ViewController: UIViewController, ViewControllerPresenterProtocol {

    static let CellIdentifier = "ImageItemCell"
    
	var presenter: ViewControllerWithTagsPresenter?
    fileprivate var imagesArray: [ImageModel]?
    
    @IBOutlet weak var tableView: UITableView?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        guard let tableView = tableView else { return }
        tableView.register(UINib(nibName: "ImageItemTableCell", bundle: nil), forCellReuseIdentifier: ViewController.CellIdentifier)
        self.title = "Public Images"
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let presenter = presenter else { return }
        presenter.loadFlickrImages()
    }
    
    func encounterError(_ errorMessage: String) {
        AlertsManager.showErrorAlert(withMessage: errorMessage, inViewController: self)
    }
    
    func succcess(imagesArray images: [ImageModel]) {
        guard let tableView = tableView else { return }
        imagesArray = images
        tableView.reloadData()
        tableView.setContentOffset(CGPoint.zero, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.bounds.size.height / 2.5
        return height
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let imagesArray = imagesArray else { return 0 }
        return imagesArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellOptional = tableView.dequeueReusableCell(withIdentifier: ViewController.CellIdentifier, for: indexPath) as? ImageItemTableCell
        guard let cell = cellOptional, let model = imagesArray?[indexPath.row] else { return UITableViewCell() }
        cell.reloadCell(withModel: model)
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            presenter?.loadFlickrImages(withTags: text)
        }
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            presenter?.loadFlickrImages()
        }
    }
}
