//
//  functions.swift
//  customButton
//
//  Created by Kira on 24.11.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

struct Helper {
    
    // Было удивлением как делается ресайз, если есть вариант проще, то с радостью послушаю
    
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
