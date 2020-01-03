//
//  Helper.swift
//  CollectionView
//
//  Created by Kira on 03.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

struct Helper {
    
    static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {

         let scale = newWidth / image.size.width
         let newHeight = image.size.height * scale
         UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
         image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

         let newImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()

         return newImage
     }
}
