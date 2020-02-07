//
//  HTTPTask.swift
//  Network
//
//  Created by Kira on 26.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask<T: Encodable> {
    case request
    
    case requestParameters(
        bodyParameters: T?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?
    )
    
    case requestParametersAndHeaders(
        bodyParameters: T?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?
    )
    
    // case download, upload...etc
}
