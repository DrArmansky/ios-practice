//
//  UserDefaultStorage.swift
//  StorageTypes
//
//  Created by Kira on 20.02.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

class UserDefaultStorage<T: StorageKeys>: StorageProtocol {
    typealias storageKeys = T
    
    func setWith(key: storageKeys, value: Any) {
        guard let data = value as? String else { return }
        UserDefaults.standard.set(data, forKey: key.rawValue)
    }
    
    func getBy(key: storageKeys) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue)
    }
    
    func removeBy(key: storageKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    func clearAll() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
           defaults.removeObject(forKey: key)
        }
    }
}
