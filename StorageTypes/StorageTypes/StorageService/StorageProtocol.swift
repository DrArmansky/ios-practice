//
//  StorageProtocol.swift
//  StorageTypes
//
//  Created by Kira on 20.02.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

protocol StorageKeys where Self : RawRepresentable, Self.RawValue == String {
}

protocol StorageProtocol {
    associatedtype storageKeys: StorageKeys
    func setWith(key: storageKeys, value: Any) -> Void
    func getBy(key: storageKeys) -> Any?
    func removeBy(key: storageKeys) -> Void
    func clearAll() -> Void
}

extension StorageProtocol {
    var className: String {
        return String(describing: type(of: self))
    }
}

