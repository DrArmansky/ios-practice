//
//  ViewController.swift
//  Coordinator
//
//  Created by Kira on 20.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func switchFirstView() {
        coordinator?.switchFirstVC()
    }
    
    @IBAction func switchSecondView() {
        coordinator?.switchSecondVC()
    }
}

