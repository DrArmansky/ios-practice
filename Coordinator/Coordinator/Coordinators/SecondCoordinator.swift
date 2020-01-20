//
//  SecondCoordinator.swift
//  Coordinator
//
//  Created by Kira on 20.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SecondCoordinator: Coordinator {
    
    //MARK: - Properties
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?

    //MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = SecondViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    /*func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }*/
}
