//
//  ImageNetworkService.swift
//  ImageCache
//
//  Created by Kira on 24.02.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

enum NetworkService {
    case zen
    case showUser(id: Int)
    case createUser(firstName: String, lastName: String)
    case updateUser(id: Int, firstName: String, lastName: String)
    case showAccounts
}
