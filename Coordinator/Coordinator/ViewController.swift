//
//  ViewController.swift
//  Coordinator
//
//  Created by Константин Савялов on 05.12.2019.
//  Copyright © 2019 Константин Савялов. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    
       override func viewDidLoad() {
           super.viewDidLoad()
       }
    
       @IBAction func buyTapped(_ sender: Any) {
        self.coordinator?.buySubscription()
       }

       @IBAction func createAccount(_ sender: Any) {
           coordinator?.createAccount()
       }
}

