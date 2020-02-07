//
//  JSONParameterEncoder.swift
//  Network
//
//  Created by Kira on 26.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder<Params: Encodable>: ParameterEncoder {
    
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Params) throws {
        
        do {
            // add body
            let jsonAsData = try JSONEncoder().encode(parameters)
            urlRequest.httpBody = jsonAsData
            
            // default content type
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}
