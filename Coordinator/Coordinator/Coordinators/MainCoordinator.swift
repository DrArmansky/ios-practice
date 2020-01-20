//
//  MainCoordinator.swift
//  Coordinator
//
//  Created by Kira on 20.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    //MARK: - Properties
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    //MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        navigationController.delegate = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    //MARK: - Navigation
    
    func switchFirstVC() {
        let vc = FirstViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func switchSecondVC() {
        let child = SecondCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        if let secondViewController = fromViewController as? SecondViewController {
            childDidFinish(secondViewController.coordinator)
        }
    }
}
