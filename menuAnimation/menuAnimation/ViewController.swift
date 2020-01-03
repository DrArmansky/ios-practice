//
//  ViewController.swift
//  menuAnimation
//
//  Created by Kira on 15.12.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menu: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        menu.layer.shadowColor = UIColor.black.cgColor
        menu.layer.shadowOpacity = 0.4
        menu.layer.shadowOffset = .zero
        menu.layer.shadowRadius = 10
        
        // попробовать удалить констрейн
        NSLayoutConstraint(item: menu, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: -menu.frame.width).isActive = true
    }


}

