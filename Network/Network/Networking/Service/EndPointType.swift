//
//  EndPointTypeProtocol.swift
//  Network
//
//  Created by Kira on 26.01.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

protocol EndPointType {
    associatedtype ParamsType: Encodable
    
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask<ParamsType> { get }
    var headers: HTTPHeaders? { get }
}
