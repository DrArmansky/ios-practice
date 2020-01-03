//
//  ImageCell.swift
//  CollectionView
//
//  Created by Kira on 10.12.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func setup(path: URL) {
        clipsToBounds = true
        contentMode = .scaleAspectFit
        
        do {
            guard let image = try UIImage(data: NSData(contentsOf: path) as Data), let resizedImage = Helper.resizeImage(image: image, newWidth: self.frame.width) else { return }
            
            imageView.image = resizedImage
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true

            backgroundColor = .red
            
        } catch let error1 as NSError {
            print(error1.description)
        }
    }
}
