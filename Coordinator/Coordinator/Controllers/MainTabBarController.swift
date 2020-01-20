//
//  MainTabBarController.swift
//  Coordinator
//
//  Created by Kira on 21.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    let mainCoordinator = MainCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        mainCoordinator.start()
        viewControllers = [mainCoordinator.navigationController]
    }
}
