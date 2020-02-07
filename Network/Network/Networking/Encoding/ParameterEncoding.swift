//
//  ParameterEncoding.swift
//  Network
//
//  Created by Kira on 26.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

public protocol ParameterEncoder {
    associatedtype Params
    static func encode(urlRequest: inout URLRequest, with parameters: Params) throws
}

public enum ParameterEncoding {
    
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    
    public func encode<T: Encodable>(
        urlRequest: inout URLRequest,
        bodyParameters: T?,
        urlParameters: Parameters?
    ) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try JSONParameterEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .urlAndJsonEncoding:
                guard let bodyParameters = bodyParameters,
                    let urlParameters = urlParameters else { return }
                try URLParameterEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
                try JSONParameterEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
                
            }
        }catch {
            throw error
        }
    }
}
