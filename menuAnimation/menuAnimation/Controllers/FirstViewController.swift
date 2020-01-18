//
//  FirstViewController.swift
//  menuAnimation
//
//  Created by Kira on 15.12.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, MenuContainerProtocol {
    
    static var menuItemId: MenuList = .first
    
    var menu: Menu?
    
    func initializeMenu() {
        menu = Menu(withViewController: self)
        menu?.setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeMenu()
    }
    
}

