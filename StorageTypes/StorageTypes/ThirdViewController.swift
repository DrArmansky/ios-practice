//
//  ThirdViewController.swift
//  StorageTypes
//
//  Created by Kira on 16.02.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    var data: [String: [String:String]] = [:]
    let UDStorage = UserDefaultStorage<FormFieldsName>()
    let FMStorage = FileManagerStorage<FormFieldsName>()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        prepareData()
        
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func prepareData() {
        if let UDStorageData = StorageDatatManager(
            storage: UDStorage
        ).getData(keys:[.login, .pass]) {
            data = data.merging(UDStorageData) { $1 }
        }
        
        if let FMStorageData = StorageDatatManager(
            storage: FMStorage
        ).getData(keys: [.name, .phone]) {
            data = data.merging(FMStorageData) { $1 }
        }
    }
    
    @IBAction func removeAll() {
        UDStorage.clearAll()
        FMStorage.clearAll()
        
        data[UDStorage.className]?.removeAll()
        data[FMStorage.className]?.removeAll()
        
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ThirdViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(data)[section].key
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(data)[section].value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value2, reuseIdentifier: "cell")

        cell.textLabel?.text = Array(Array(data)[indexPath.section].value)[indexPath.row].key
        cell.detailTextLabel?.text = Array(Array(data)[indexPath.section].value)[indexPath.row].value

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currentDataType = Array(data)[indexPath.section].key
            guard let currentData = data[currentDataType] else { return }
            
            let currentDataKey = Array(currentData)[indexPath.row].key
            guard let fieldKey = FormFieldsName(rawValue: currentDataKey) else { return }
            
            switch currentDataType {
                case UDStorage.className:
                    UDStorage.removeBy(key: fieldKey)
                case FMStorage.className:
                    FMStorage.removeBy(key: fieldKey)
                default: break
            }
            
            tableView.beginUpdates()
            data[currentDataType]?.removeValue(forKey: currentDataKey)
            tableView.deleteRows(at: [ indexPath ], with: .automatic)
            tableView.endUpdates()
        }
    }

}
