//
//  ResponseModel.swift
//  ImageCache
//
//  Created by Kira on 01.03.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

struct ImageResponseModel: Decodable, Equatable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
