//
//  ReqestModel.swift
//  Network
//
//  Created by Kira on 03.02.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

struct PostRequest: Encodable {
    var id: Int?
    var userId: Int
    var title: String
    var body: String
}
