//
//  customButtonController.swift
//  customButton
//
//  Created by Kira on 16.11.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class CustomButtonController: UIButton {
    
    var icon: UIImage?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setContent()
        setSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setContent()
        setSettings()
    }
    
    private func setSettings() {

        frame = CGRect(x: 100, y: 100, width: (icon?.size.width ?? 100) * 2, height: (icon?.size.height ?? 100) * 2)

        backgroundColor = UIColor.clear
        setupBorder(color: UIColor.black.cgColor, width: 2, cornerRadius: 5)
    }
    
    private func setContent() {
        
        icon = resizeImage(image: UIImage(named: "avatar")!, newWidth: 80)
        let iconView = UIImageView(image: icon)
        
        let label = UILabel()
        label.text = "It is nice."
        addPreparedStack(views: [iconView, label])
    }
    
    // Формируем stackview
    
    private func addPreparedStack(views: [UIView]) {
        
        let stack = UIStackView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 10

        views.forEach { item in
            stack.addArrangedSubview(item)
        }

        self.addSubview(stack)
    }
    
    private func setupBorder(color: CGColor, width: CGFloat, cornerRadius: CGFloat) {
        
        layer.borderColor = color
        layer.borderWidth = width
        layer.cornerRadius = cornerRadius
    }

    // Было удивлением как делается ресайз, если есть вариант проще, то с радостью послушаю
    
    private func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {

         let scale = newWidth / image.size.width
         let newHeight = image.size.height * scale
         UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
         image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

         let newImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()

         return newImage
     }

}
