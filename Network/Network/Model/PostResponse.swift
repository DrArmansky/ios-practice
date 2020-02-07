//
//  Movie.swift
//  Network
//
//  Created by Kira on 03.02.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

struct PostResponse: Decodable {
    let id: Int
    let userId: Int?
    let title: String?
    let body: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case title
        case body
    }
}
