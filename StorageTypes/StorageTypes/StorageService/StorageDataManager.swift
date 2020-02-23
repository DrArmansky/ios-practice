//
//  DataManager.swift
//  StorageTypes
//
//  Created by Kira on 18.02.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

enum FormFieldsName: String, StorageKeys {
    case login
    case pass
    case name
    case phone
}
 
class StorageDatatManager<T: StorageProtocol> {
    
    private var result: [String: [String: String]] = [:]
    private var storage: T
    
    init(storage: T) {
        self.storage = storage
    }
    
    func getData(keys: [T.storageKeys]) -> [String: [String:String]]? {
        result[self.storage.className] = [:]
        keys.forEach { key in
            guard let value = self.storage.getBy(key: key) as? String else { return }
            result[self.storage.className]?[key.rawValue] = value
        }
        return result
    }
}
