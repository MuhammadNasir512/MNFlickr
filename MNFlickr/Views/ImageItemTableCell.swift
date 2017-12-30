//
//  ImageItemTableCell.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 30/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit
import SDWebImage

class ImageItemTableCell: UITableViewCell {
    
    @IBOutlet weak var imageViewItem: UIImageView?
    var imageModel: ImageModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func reloadCell(withModel imageModel: ImageModel) {
        guard let imageViewItem = imageViewItem else { return }
        let url = imageModel.url
        imageViewItem.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
    }
    
}
