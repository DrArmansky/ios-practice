//
//  FourthViewController.swift
//  menuAnimation
//
//  Created by Kira on 09.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController, MenuContainerProtocol {
    
    static var menuItemId: MenuList = .fourth
    
    var menu: Menu?
    
    func initializeMenu() {
        menu =  Menu(withViewController: self)
        menu?.setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeMenu()
    }
}
