//
//  CoordinatorProtocol.swift
//  Coordinator
//
//  Created by Kira on 20.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    
    //MARK: - Properties
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
