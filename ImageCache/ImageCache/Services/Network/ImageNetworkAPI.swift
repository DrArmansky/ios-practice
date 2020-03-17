//
//  ImageNetworkService.swift
//  ImageCache
//
//  Created by Kira on 29.02.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Moya
import Foundation

enum ImageNetworkAPI {
    case get
    case download(url: URL)
}

extension ImageNetworkAPI: TargetType {
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .get:
            return .requestPlain
        case .download:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var baseURL: URL {
        switch self {
        case .download(let url):
            return url
        default:
            return URL(string: "https://jsonplaceholder.typicode.com")!
        }
    }
    
    var path: String {
        switch self {
        case .get:
            return "photos"
        default:
            return ""
        }
    }
}
