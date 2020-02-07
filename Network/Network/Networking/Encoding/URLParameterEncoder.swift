//
//  URLParameterEncoder.swift
//  Network
//
//  Created by Kira on 26.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

public typealias Parameters = [String:Any]

public struct URLParameterEncoder: ParameterEncoder {
    public typealias Params = Parameters
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Params) throws {
        
        // check url
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        // init urlComponents and check parameters array
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            // fill queryItems array
            for (key,value) in parameters {
                let queryItem = URLQueryItem(name: key,
                                             value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        // set default Content-Type
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
    }
}
