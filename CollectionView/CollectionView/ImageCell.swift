//
//  ImageCell.swift
//  CollectionView
//
//  Created by Kira on 10.12.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /*func setup(imageName: String) {
        image.contentMode = .scaleAspectFit
    }*/
    
    func setup(color: UIColor) {
        backgroundColor = color
    }
}
