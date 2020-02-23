//
//  SecondViewController.swift
//  StorageTypes
//
//  Created by Kira on 16.02.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    private let storage = FileManagerStorage<FormFieldsName>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveToFileManager() {
        if let nameText = name.text {
            storage.setWith(key: .name, value: nameText)
        }
        if let phoneText = phone.text {
            storage.setWith(key: .phone, value: phoneText)
        }
        
        name.text = ""
        phone.text = ""
        view.endEditing(true)
    }
}
