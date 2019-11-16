//
//  CustomButtonViewController.swift
//  customButton
//
//  Created by Kira on 16.11.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButtonViewController: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setSettings()
    }
    
    private func setSettings() {
        layer.borderColor = .init(srgbRed: 200, green: 200, blue: 200, alpha: 1)
        
        layer.borderWidth = 2
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
