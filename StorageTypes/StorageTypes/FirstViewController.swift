//
//  ViewController.swift
//  StorageTypes
//
//  Created by Kira on 10.02.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    let storage = UserDefaultStorage<FormFieldsName>()
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveToUserDefaults() {
        if let loginText = login.text {
            storage.setWith(key: .login, value: loginText)
        }
        if let passText = pass.text {
            storage.setWith(key: .pass, value: passText)
        }
        
        login.text = ""
        pass.text = ""
        view.endEditing(true)
    }
}

