//
//  menuItemProtocol.swift
//  menuAnimation
//
//  Created by Kira on 13.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

protocol MenuContainerProtocol {
    static var menuItemId: MenuList { get }
    var menu: Menu? { get set }
    func initializeMenu()
}

