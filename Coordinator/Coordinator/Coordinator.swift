//
//  Coordinator.swift
//  Coordinator
//
//  Created by Константин Савялов on 05.12.2019.
//  Copyright © 2019 Константин Савялов. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
