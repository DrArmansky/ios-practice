//
//  PictureEndPoint.swift
//  Network
//
//  Created by Kira on 03.02.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

public enum PostEndPoint {
    case posts
    case newPost(body: Encodable)
}


extension PostEndPoint: EndPointType {
    typealias ParamsType = PostRequest
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
            case .production: return "https://jsonplaceholder.typicode.com/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
            default:
                return "posts"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            case .posts:
                return .get
            case .newPost:
                return .post
        }
    }
    
    var task: HTTPTask<ParamsType> {
        switch self {
            case .newPost(let body):
                return .requestParameters(
                    bodyParameters: body as? ParamsType,
                    bodyEncoding: .urlEncoding,
                    urlParameters: nil
                )
            default:
                return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
