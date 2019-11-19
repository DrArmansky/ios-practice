//
//  ViewController.swift
//  customButton
//
//  Created by Kira on 16.11.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton()
    }

    private func addButton() {
        
        let button = CustomButtonController()
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

