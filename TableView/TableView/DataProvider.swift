//
//  DataProvider.swift
//  TableView
//
//  Created by Kira on 07.12.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class DataProvider {

    static var data: [SomeModel] = {
        var count = 0
        return (1...100).map { "Lorem ipsum ipsilon bla blabla \($0)" }
            .map { item in
                var result = item
                for _ in 0...(count % 3) {
                    count += 1
                    result += " \(item)"
                }
                return SomeModel(text: result, isChecked: false)
        }
    }()

}
