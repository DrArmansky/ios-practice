//
//  SecondViewController.swift
//  Coordinator
//
//  Created by Kira on 20.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, Storyboarded {

    weak var coordinator: SecondCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.didFinish()
    }*/
}
